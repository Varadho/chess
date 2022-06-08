import 'package:flutter/foundation.dart';

import '../squares/piece.dart';
import 'board_state.dart';
import 'coordinate.dart';

class BoardStateNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  BoardState boardState;
  Coordinate? _selectedCoord;
  int halfMoveClock;
  int fullMoveNumber;
  bool isWhitesMove;

  Coordinate? get selectedCoord => _selectedCoord;

  Piece? get selectedPiece {
    if (_selectedCoord != null &&
        boardState.squares[_selectedCoord!.y][_selectedCoord!.x] is Piece)
      return boardState.squares[_selectedCoord!.y][_selectedCoord!.x] as Piece;
    return null;
  }

  set selectedCoord(Coordinate? selectedSquare) {
    _selectedCoord = selectedSquare;
    boardState = boardState.clearLegalMoves();
    if (selectedPiece != null) {
      boardState = boardState.showLegalMoves(
        selectedPiece!.legalMoves(boardState, _selectedCoord!),
      );
    }
    notifyListeners();
  }

  Coordinate? get enPassantTarget => boardState.enPassantTarget;

  set enPassantTarget(Coordinate? coordinate) =>
      boardState = boardState.copyWith(enPassantTarget: coordinate);

  void nextMove() {
    halfMoveClock++;
    if (!isWhitesMove) {
      fullMoveNumber++;
    }
    isWhitesMove = !isWhitesMove;
    selectedCoord = null;
    notifyListeners();
  }

  BoardStateNotifier({
    required this.boardState,
    this.halfMoveClock = 0,
    this.fullMoveNumber = 0,
    this.isWhitesMove = true,
  });

  void move({required Coordinate target}) {
    final piece =
        boardState.squares[selectedCoord!.y][selectedCoord!.x] as Piece;
    boardState.squares[selectedCoord!.y][selectedCoord!.x] = Square();
    boardState.squares[target.y][target.x] = piece;

    boardState = boardState.clearLegalMoves();
    //Extraworscht für Beförderung und enPassant
    if (piece is Pawn) {
      //Promoting
      if (target.y == (isWhitesMove ? 7 : 0)) {
        boardState.squares[target.y][target.x] = Queen(isWhite: piece.isWhite);
      }
      if (target == enPassantTarget) {
        boardState.squares[target.y + (isWhitesMove ? -1 : 1)][target.x] =
            Square();
      }
      //Setting en passant
      if (selectedCoord!.y == (isWhitesMove ? 1 : 6) &&
          target.y == (isWhitesMove ? 3 : 4)) {
        final enPassantTarget = Coordinate(
          target.x,
          target.y + (isWhitesMove ? -1 : 1),
        );
        boardState = boardState.copyWith(enPassantTarget: enPassantTarget);
      } else {
        boardState = boardState.copyWith(enPassantTarget: Coordinate(-1, -1));
      }
    } else {
      boardState = boardState.copyWith(enPassantTarget: Coordinate(-1, -1));
    }

    print('enPassantTarget: $enPassantTarget');
    nextMove();
  }

  void resetGame() {
    halfMoveClock = 0;
    fullMoveNumber = 0;
    isWhitesMove = true;
    _selectedCoord = null;
    boardState = BoardState.newGame();
    notifyListeners();
  }
}
