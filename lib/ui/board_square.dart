import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board/coordinate.dart';
import '../models/board/game_state_notifier.dart';
import '../models/squares/piece.dart';

class BoardSquare extends StatelessWidget {
  final Coordinate coord;
  final bool isLightSquare;

  BoardSquare({
    required this.isLightSquare,
    required this.coord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameStateNotifier>(context);
    final isKingAndCheck =
        state.boardState.kingSquare(isWhite: state.isWhitesMove) == coord &&
            state.boardState.isCheck(isWhite: state.isWhitesMove);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleClick(state),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isLightSquare ? Colors.white : Colors.brown,
              gradient: isKingAndCheck
                  ? RadialGradient(
                      focalRadius: 0.3,
                      colors: [
                        Colors.red,
                        if (isLightSquare) Colors.white else Colors.brown,
                      ],
                    )
                  : null,
            ),
            child: _squareContent(state),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              coord.toString(),
            ), //('${FILES[coord.x]}${RANKS[coord.y]}'),
          ),
        ],
      ),
    );
  }

  /// This method handles the clicking on a square as part of the UI.
  /// First it checks the content of the clicked square and depending on that
  void _handleClick(GameStateNotifier state) {
    // On click of a square containing one of the current players pieces
    final isCurrentPlayersPiece =
        state.boardState.getPiece(coord)?.isWhite == state.isWhitesMove;

    // No piece is selected and the square does not contain the current players color
    final hasNoAction = !isCurrentPlayersPiece &&
        !state.boardState.squares[coord.y][coord.x].isLegalTarget;

    if (hasNoAction) {
      state.selectedCoord = null;
      return;
    }
    if (isCurrentPlayersPiece) {
      state.selectedCoord = coord;
      return;
    }
    state.moveTo(coord);
  }

  Widget? _squareContent(GameStateNotifier state) {
    // Extract the square information based on [this.coord] from the game state
    final square = state.boardState.squares[coord.y][coord.x];
    // The square is empty and not a legal target
    if (!square.isLegalTarget && square is! Piece) {
      return null;
    }
    // The square is occupied...
    if (square is Piece) {
      // ...but not a legal target -> simply show the figurine
      if (!square.isLegalTarget) {
        return square.figurine();
      }
      // ...and legal target -> add green border
      else {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green.withOpacity(0.6), width: 4),
            color: Colors.transparent,
          ),
          child: square.figurine(),
        );
      }
    }
    // We're only left with empty legal target squares.
    return Center(
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
