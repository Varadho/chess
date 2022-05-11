import 'package:flutter/foundation.dart';

import 'board_state.dart';
import 'square.dart';

class BoardStateNotifier with ChangeNotifier, DiagnosticableTreeMixin {
  BoardState boardState;
  Square? _selectedSquare;
  int halfMoveClock;
  int fullMoveNumber;
  bool isWhitesMove;

  Square? get selectedSquare => _selectedSquare;

  set selectedSquare(Square? selectedSquare) {
    print(
        'selecting ${selectedSquare?.piece.runtimeType} on ${selectedSquare?.name}');
    _selectedSquare = selectedSquare;
    if (_selectedSquare != null) {
      boardState = boardState.withLegalMoves(
        _selectedSquare!.piece!.legalMoves(boardState, _selectedSquare!),
      );
    }
    notifyListeners();
  }

  void nextMove() {
    halfMoveClock++;
    if (!isWhitesMove) fullMoveNumber++;
    isWhitesMove = !isWhitesMove;
    selectedSquare = null;
    notifyListeners();
  }

  BoardStateNotifier({
    this.halfMoveClock = 0,
    this.fullMoveNumber = 0,
    this.isWhitesMove = true,
    required this.boardState,
  });

  void move({required Square target}) {
    nextMove();
  }
}
