import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:my_own_chess/models/squares/piece.dart';

import '../squares/square.dart';
import 'board_state.dart';
import 'coordinate.dart';

class BoardStateNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  BoardState boardState;
  Coordinate? _selectedCoord;
  int halfMoveClock;
  int fullMoveNumber;
  bool isWhitesMove;

  Coordinate? get selectedCoord => _selectedCoord;

  Piece? get selectedPiece {
    if (_selectedCoord != null &&
        boardState.squares[_selectedCoord!.x][_selectedCoord!.y] is Piece)
      return boardState.squares[_selectedCoord!.x][_selectedCoord!.y] as Piece;
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

  void nextMove() {
    halfMoveClock++;
    if (!isWhitesMove) fullMoveNumber++;
    isWhitesMove = !isWhitesMove;
    selectedCoord = null;
    notifyListeners();
  }

  BoardStateNotifier({
    this.halfMoveClock = 0,
    this.fullMoveNumber = 0,
    this.isWhitesMove = true,
    required this.boardState,
  });

  void move({required Coordinate target}) {
    Piece piece =
        boardState.squares[selectedCoord!.x][selectedCoord!.y] as Piece;
    boardState.squares[selectedCoord!.x][selectedCoord!.y] = Square();
    boardState.squares[target.x][target.y] = piece;

    boardState = boardState.clearLegalMoves();
    if (piece is Pawn && target.y == (isWhitesMove ? 7 : 0))
      boardState.squares[target.x][target.y] = Queen(isWhite: piece.isWhite);
    nextMove();
  }

  void resetGame() {
    halfMoveClock = 0;
    fullMoveNumber = 0;
    isWhitesMove = true;
    _selectedCoord = null;
    boardState = BoardState();
    notifyListeners();
  }
}
