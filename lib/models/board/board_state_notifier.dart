import 'package:flutter/foundation.dart';

import '../squares/piece.dart';
import 'board_state.dart';
import 'coordinate.dart';

class GameStateNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  BoardState boardState;
  Coordinate? _selectedCoord;
  int halfMoveClock;
  int fullMoveNumber;

  bool get isWhitesMove => halfMoveClock.isEven;

  Coordinate? get selectedCoord => _selectedCoord;

  Piece? get selectedPiece =>
      boardState.getPiece(_selectedCoord ?? Coordinate(-1, -1));

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
    if (isWhitesMove) {
      fullMoveNumber++;
    }
    selectedCoord = null;
    notifyListeners();
  }

  GameStateNotifier({
    required this.boardState,
    this.halfMoveClock = 0,
    this.fullMoveNumber = 0,
  });

  void move({required Coordinate target}) {
    //Move piece to target location by replacement
    final piece = boardState.getPiece(selectedCoord!)!;
    boardState.squares[selectedCoord!.y][selectedCoord!.x] = Square();
    boardState.squares[target.y][target.x] = piece;

    //Restore pristine board state
    enPassantTarget = null;
    boardState = boardState.clearLegalMoves();

    //Extrawoscht für Beförderung und enPassant
    if (piece is Pawn) {
      //Promoting
      if (target.y == (isWhitesMove ? 7 : 0)) {
        boardState.squares[target.y][target.x] = Queen(isWhite: piece.isWhite);
      }
      //Taking en passant
      if (target == enPassantTarget) {
        boardState.squares[target.y + (isWhitesMove ? -1 : 1)][target.x] =
            Square();
      }
      //Setting en passant
      final isFirstMove = selectedCoord!.y == (isWhitesMove ? 1 : 6);
      final movingTwoSquares = target.y == (isWhitesMove ? 3 : 4);
      if (isFirstMove && movingTwoSquares) {
        enPassantTarget = Coordinate(
          target.x,
          target.y + (isWhitesMove ? -1 : 1),
        );
      }
    }
    if (piece is King) {
      //TODO Are we castling?

      //TODO Modify castling rights
    }
    nextMove();
  }

  void resetGame() {
    halfMoveClock = 0;
    fullMoveNumber = 0;
    _selectedCoord = null;
    boardState = BoardState.newGame();
    notifyListeners();
  }
}
