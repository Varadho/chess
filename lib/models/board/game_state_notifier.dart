import 'package:flutter/foundation.dart';

import '../constants.dart';
import '../squares/piece.dart';
import 'board_state.dart';
import 'coordinate.dart';
import 'move.dart';

class GameStateNotifier extends ChangeNotifier with DiagnosticableTreeMixin {
  /// Indicates whether the game is in progress, drawn or won/lost
  GameState gameState;

  /// All relevant information about the current state of the board.
  BoardState boardState;

  /// A record of previous moves
  List<Move> moves;

  /// The currently selected (last clicked) square on the Chess-board
  Coordinate? _selectedCoord;

  /// A move counter which increments every time a player makes a move
  int halfMoveClock;

  /// The number of the last move on which a pawn move or capture occurred.
  int lastCaptureOrPawnMove;

  GameStateNotifier({
    required this.boardState,
    this.halfMoveClock = 0,
    this.lastCaptureOrPawnMove = 0,
    List<Move>? moves,
    GameState? gameState,
  })  : this.gameState = gameState ?? GameState.PLAYING,
        this.moves = moves ?? [];

  /// Represents the number of turns that both players have made
  int get fullMoveNumber => (halfMoveClock / 2).round();

  /// A boolean which indicates whose move it is. Based on the half move clock.
  bool get isWhitesMove => halfMoveClock.isEven;

  /// The currently selected Coordinate (hidden behind a getter, since setting it always needs additional operations)
  Coordinate? get selectedCoord => _selectedCoord;

  /// Sets a new selected coordinate.
  /// Hides previously displayed legal moves.
  /// Displays legal moves if a piece occupies the selected coordinate.
  /// Informs UI-Elements to re-render
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

  /// Returns the Piece standing on the selected square, or null if it is empty.
  Piece? get selectedPiece =>
      boardState.getPiece(_selectedCoord ?? Coordinate(-1, -1));

  /// The coordinate of the en-passant target, proxy-ed from the BoardState
  Coordinate? get enPassantTarget => boardState.enPassantTarget;

  /// BoardState proxy, see above
  set enPassantTarget(Coordinate? coordinate) =>
      boardState = boardState.copyWith(enPassantTarget: coordinate);

  /// Based on a [target] coordinate and the stored [selectedCoord]
  /// creates a move and applies it to the [BoardState].
  /// Follows up by either ending the game or waiting for the next move.
  void moveTo(Coordinate target) {
    final move = boardState.squares[target.y][target.x] is Piece
        ? Capture(
            start: selectedCoord!,
            target: target,
            capturedPiece: boardState.squares[target.y][target.x] as Piece,
          )
        : Move(start: selectedCoord!, target: target);

    if (move is Capture || selectedPiece is Pawn) {
      lastCaptureOrPawnMove = halfMoveClock;
    }

    boardState = boardState.applyMove(move);

    if (boardState.isCheckmate(isWhite: !isWhitesMove)) {
      gameState = GameState.WIN;
      finishGame();
    } else if (boardState.isStalemate(isWhite: !isWhitesMove) ||
        halfMoveClock - lastCaptureOrPawnMove == 100) {
      gameState = GameState.DRAW;
      finishGame();
    } else {
      nextMove();
    }
  }

  /// "Finishes" the game. Notifies listeners to update UI-State,
  /// waits for 5 seconds and then resets the game.
  Future<void> finishGame() async {
    notifyListeners();
    await Future.delayed(Duration(seconds: 5));
    resetGame();
  }

  /// Continues with the next move by:
  /// 1. incrementing the half-move-clock
  /// 2. resetting the selected coordinate.
  ///   2.1. Notifying the UI
  void nextMove() {
    halfMoveClock++;
    selectedCoord = null;
  }

  /// Resets the Game by assigning the values from the standard constructor
  /// and notifying the UI
  void resetGame() {
    halfMoveClock = 0;
    _selectedCoord = null;
    boardState = BoardState.newGame();
    gameState = GameState.PLAYING;
    notifyListeners();
  }

  /// Sets the Game up with a "queen endgame board" state.
  /// Used for debugging purposes e.g. checking for Stalemate.
  void queenEndgame() {
    halfMoveClock = 0;
    _selectedCoord = null;
    boardState = BoardState.queenEndgame();
    gameState = GameState.PLAYING;
    notifyListeners();
  }
}
