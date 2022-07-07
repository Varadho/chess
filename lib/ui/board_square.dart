import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board/coordinate.dart';
import '../models/board/game_state_notifier.dart';
import '../models/squares/piece.dart';

class BoardSquare extends StatelessWidget {
  final Square square;
  final Coordinate coord;
  final bool isWhite;

  BoardSquare({
    required this.square,
    required this.isWhite,
    required this.coord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameStateNotifier>(context);
    final isKingAndCheck = square is King &&
        state.boardState.isCheck(isWhite: (square as King).isWhite);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: state.isLatestBoardState ? () => _handleClick(state) : null,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isWhite ? Colors.white : Colors.brown,
              gradient: isKingAndCheck
                  ? RadialGradient(
                      focalRadius: .3,
                      colors: [
                        Colors.red,
                        if (isWhite) Colors.white else Colors.brown,
                      ],
                    )
                  : null,
            ),
            child: _squareContent(),
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

  void _handleClick(GameStateNotifier state) {
    if (state.boardState == state.lastBoardState) {
      print('handling click!');
      // On click of a square containing one of the current players pieces
      final isCurrentPlayersPiece =
          square is Piece && (square as Piece).isWhite == state.isWhitesMove;

      // No piece is selected and the square does not contain the current players color
      final hasNoAction = !isCurrentPlayersPiece && !square.isLegalTarget;
      if (hasNoAction) {
        state.selectedCoord = null;
        return;
      }
      if (isCurrentPlayersPiece) {
        state.selectedCoord = coord;
        return;
      }
      // If a piece is already selected and the clicked square is a legal target.
      final validMove = (state.selectedCoord != null) && square.isLegalTarget;
      if (validMove) {
        state.move(target: coord);
      }
    }
  }

  Widget? _squareContent() {
    // Empty Square
    if (!square.isLegalTarget && square is! Piece) {
      return null;
    }
    // Occupied square
    if (square is Piece) {
      final piece = square as Piece;
      // Occupied square which can't be captured
      if (!piece.isLegalTarget) {
        return piece.figurine();
      } else {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green.withOpacity(0.6), width: 4),
            color: Colors.transparent,
          ),
          child: piece.figurine(),
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
