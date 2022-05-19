import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:my_own_chess/models/pieces/piece.dart';

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
    _selectedSquare = selectedSquare;
    boardState = boardState.clearLegalMoves();
    if (_selectedSquare != null) {
      boardState = boardState.showLegalMoves(
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
    boardState = boardState.copyWith(
      squares: boardState.squares.map(
        (square) {
          if (square.rank == target.rank && square.file == target.file)
            return square.copyWith(piece: selectedSquare?.piece);
          if (square.rank == selectedSquare?.rank &&
              square.file == selectedSquare?.file) {
            return Square(square.file, square.rank);
          }
          return square;
        },
      ).toList(),
    );
    boardState = boardState.clearLegalMoves();
    if (selectedSquare?.piece is Pawn && target.rank == (isWhitesMove ? 8 : 1))
      print('Promoting a pawn!');
    nextMove();
  }

  void resetGame() {
    halfMoveClock = 0;
    fullMoveNumber = 0;
    isWhitesMove = true;
    _selectedSquare = null;
    boardState = BoardState();
    notifyListeners();
  }
}
