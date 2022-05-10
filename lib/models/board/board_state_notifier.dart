import 'package:flutter/foundation.dart';

import 'board_state.dart';
import 'square.dart';

class BoardStateNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  BoardState boardState;
  Square? _selectedSquare;
  int halfMoveClock;
  int fullMoveNumber;
  String currentPlayer;

  bool get isWhitesMove => currentPlayer == 'w';

  Square? get selectedSquare => _selectedSquare;

  set selectedSquare(Square? selectedSquare) {
    _selectedSquare = selectedSquare;
    if (_selectedSquare != null) {
      List<Square> moves =
          _selectedSquare?.piece?.legalMoves(boardState, _selectedSquare!) ??
              [];
      for (Square target in moves) {
        boardState.squares.removeWhere((sq) => sq.name == target.name);
      }
      boardState.squares.addAll(moves);
      boardState.squares.sort();
    }
    notifyListeners();
  }

  void nextMove() {
    halfMoveClock++;
    if (!isWhitesMove) fullMoveNumber++;
    currentPlayer = isWhitesMove ? 'b' : 'w';
    selectedSquare = null;
  }

  BoardStateNotifier({
    this.halfMoveClock = 0,
    this.fullMoveNumber = 0,
    this.currentPlayer = 'w',
    required this.boardState,
  });

  void move({required Square target}) {
    nextMove();
  }
}
