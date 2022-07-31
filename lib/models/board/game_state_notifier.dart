import 'package:flutter/foundation.dart';

import '../squares/piece.dart';
import 'board_state.dart';
import 'coordinate.dart';

class GameStateNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  BoardState boardState;
  Coordinate? _selectedCoord;
  int halfMoveClock;
  int lastCaptureOrPawnMove;

  int get fullMoveNumber => (halfMoveClock / 2).round();

  bool get isWhitesMove => halfMoveClock.isEven;

  Coordinate? get selectedCoord => _selectedCoord;

  Piece? get selectedPiece =>
      boardState.getPiece(_selectedCoord ?? Coordinate(-1, -1));

  set selectedCoord(Coordinate? selectedSquare) {
    _selectedCoord = selectedSquare;
    boardState.clearLegalMoves();
    if (selectedPiece != null) {
      boardState.showLegalTargetCoordinates(
        selectedPiece!
            .legalMoves(boardState, _selectedCoord!)
            .map<Coordinate>((move) => move.target)
            .toList(),
      );
    }
    notifyListeners();
  }

  Coordinate? get enPassantTarget => boardState.enPassantTarget;

  set enPassantTarget(Coordinate? coordinate) =>
      boardState..copyWith(enPassantTarget: coordinate);

  void nextMove() {
    halfMoveClock++;
    selectedCoord = null;
    notifyListeners();
  }

  GameStateNotifier({
    required this.boardState,
    this.halfMoveClock = 0,
    this.lastCaptureOrPawnMove = 0,
  });

  // TODO Refactor this into smaller units. clean up while you're at it
  void move({required Coordinate target}) {
    //Move piece to target location by replacement
    final piece = boardState.getPiece(selectedCoord!)!;
    boardState..clearLegalMoves();

    final newSquares =
        boardState.squares.map((files) => files.toList()).toList()
          ..[selectedCoord!.y][selectedCoord!.x] = Square()
          ..[target.y][target.x] = piece;

    var nextBoardState = boardState.copyWith(squares: newSquares);

    switch (piece.runtimeType) {
      case Pawn:
        //Promoting
        if (target.y == (isWhitesMove ? 7 : 0)) {
          nextBoardState.squares[target.y][target.x] =
              Queen(isWhite: piece.isWhite);
        }
        //Taking en passant
        if (target == enPassantTarget) {
          nextBoardState.squares[target.y + (isWhitesMove ? -1 : 1)][target.x] =
              Square();
        }
        enPassantTarget = null;
        //Setting en passant
        final isMovingTwoSquares =
            target.y - selectedCoord!.y == (isWhitesMove ? 2 : -2);
        if (isMovingTwoSquares) {
          enPassantTarget = Coordinate(
            target.x,
            target.y + (isWhitesMove ? -1 : 1),
          );
        }
        break;
      case King:
        if ((target - _selectedCoord!).dx == 2 &&
            nextBoardState.castlingRights.contains(isWhitesMove ? 'K' : 'k')) {
          final rook = nextBoardState.getPiece(Coordinate(7, target.y))!;
          nextBoardState.squares[target.y][7] = Square();
          nextBoardState.squares[target.y][5] = rook;
        }
        if ((target - _selectedCoord!).dx == -2 &&
            nextBoardState.castlingRights.contains(isWhitesMove ? 'Q' : 'q')) {
          final rook = nextBoardState.getPiece(Coordinate(0, target.y))!;
          nextBoardState.squares[target.y][0] = Square();
          nextBoardState.squares[target.y][3] = rook;
        }
        nextBoardState = nextBoardState.copyWith(
          castlingRights: nextBoardState.castlingRights
              .replaceFirst(isWhitesMove ? 'K' : 'k', '')
              .replaceFirst(isWhitesMove ? 'Q' : 'q', ''),
        );
        enPassantTarget = null;
        break;
      case Rook:
        if (_selectedCoord!.x == 0 || _selectedCoord!.x == 7) {
          final kingSide = _selectedCoord!.x == 7;
          final toBeRemoved;
          if (kingSide) {
            if (isWhitesMove) {
              toBeRemoved = 'K';
            } else {
              toBeRemoved = 'k';
            }
          } else {
            if (isWhitesMove) {
              toBeRemoved = 'Q';
            } else {
              toBeRemoved = 'q';
            }
          }
          nextBoardState = nextBoardState.copyWith(
            castlingRights:
                nextBoardState.castlingRights.replaceFirst(toBeRemoved, ''),
          );
        }
        enPassantTarget = null;
        break;
      default:
        enPassantTarget = null;
        break;
    }

    if (boardState.isCheckmate(isWhite: !isWhitesMove)) {
      resetGame();
    } else {
      boardState = nextBoardState.clearLegalMoves();
      nextMove();
    }
  }

  void resetGame() {
    halfMoveClock = 0;
    _selectedCoord = null;
    boardState = BoardState.newGame();
    notifyListeners();
  }
}
