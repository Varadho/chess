import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:my_own_chess/models/board/coordinate.dart';
import 'package:my_own_chess/models/squares/piece.dart';
import 'package:my_own_chess/models/squares/square.dart';
import 'package:provider/provider.dart';

class BoardSquare extends StatelessWidget {
  final Square square;
  final Coordinate coord;
  final bool isWhite;

  BoardSquare({
    Key? key,
    required this.square,
    required this.isWhite,
    required this.coord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoardStateNotifier state = Provider.of<BoardStateNotifier>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.start,
      onTap: () => _handleClick(state),
      child: Container(
        color: isWhite ? Colors.white : Colors.brown,
        child: _squareContent(),
      ),
    );
  }

  void _handleClick(BoardStateNotifier state) {
    // On click of a square containing one of the current players pieces
    bool isCurrentPlayersPiece =
        square is Piece && (square as Piece).isWhite == state.isWhitesMove;

    // No piece is selected and the square does not contain the current players color
    bool hasNoAction = !isCurrentPlayersPiece && !square.isLegalTarget;
    if (hasNoAction) {
      state.selectedCoord = null;
      return;
    }
    if (isCurrentPlayersPiece) {
      state.selectedCoord = coord;
      return;
    }
    // If a piece is already selected and the clicked square is a legal target.
    bool validMove = (state.selectedCoord != null) && square.isLegalTarget;
    if (validMove) {
      state.move(target: coord);
    }
  }

  Widget? _squareContent() {
    // Empty Square
    if (!square.isLegalTarget && square is! Piece) return null;
    // Occupied square
    if (square is Piece) {
      Piece piece = square as Piece;
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
