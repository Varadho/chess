import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../squares/piece.dart';
import 'board_state.dart';
import 'coordinate.dart';
import 'move.dart';

class GameStateNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  GameState gameState;
  BoardState boardState;
  List<Move> moves;
  Coordinate? _selectedCoord;
  int halfMoveClock;
  int lastCaptureOrPawnMove;

  GameStateNotifier({
    required this.boardState,
    this.halfMoveClock = 0,
    this.lastCaptureOrPawnMove = 0,
    List<Move>? moves,
    GameState? gameState,
  })  : this.gameState = gameState ?? GameState.PLAYING,
        this.moves = moves ?? [];

  int get fullMoveNumber => (halfMoveClock / 2).round();

  bool get isWhitesMove => halfMoveClock.isEven;

  Coordinate? get selectedCoord => _selectedCoord;

  Piece? get selectedPiece =>
      boardState.getPiece(_selectedCoord ?? Coordinate(-1, -1));

  Coordinate? get enPassantTarget => boardState.enPassantTarget;

  set enPassantTarget(Coordinate? coordinate) =>
      boardState = boardState.copyWith(enPassantTarget: coordinate);

  set selectedCoord(Coordinate? selectedSquare) {
    _selectedCoord = selectedSquare;
    boardState = boardState.clearLegalMoves();
    if (selectedPiece != null) {
      boardState.displayLegalMoves(
        selectedPiece!.legalMoves(boardState, _selectedCoord!),
      );
    }
    notifyListeners();
  }

  void moveTo(Coordinate target) {
    final move = boardState.squares[target.y][target.x] is Piece
        ? Capture(
            start: selectedCoord!,
            target: target,
            capturedPiece: boardState.squares[target.y][target.x] as Piece,
          )
        : Move(start: selectedCoord!, target: target);
    boardState = boardState.applyMove(move);

    if (boardState.isCheckmate(isWhite: !isWhitesMove)) {
      gameState = GameState.WIN;
      finishGame();
    } else if (boardState.isStalemate(isWhite: !isWhitesMove)) {
      gameState = GameState.DRAW;
      finishGame();
    } else {
      nextMove();
    }
  }

  Future<void> finishGame() async {
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    resetGame();
  }

  void nextMove() {
    halfMoveClock++;
    selectedCoord = null;
    notifyListeners();
  }

  void resetGame() {
    halfMoveClock = 0;
    _selectedCoord = null;
    boardState = BoardState.newGame();
    gameState = GameState.PLAYING;
    notifyListeners();
  }
}
