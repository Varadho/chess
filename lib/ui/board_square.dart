import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:my_own_chess/models/board/square.dart';
import 'package:provider/provider.dart';

class BoardSquare extends StatelessWidget {
  final Square square;

  BoardSquare({Key? key, required this.square}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoardStateNotifier state = Provider.of<BoardStateNotifier>(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      dragStartBehavior: DragStartBehavior.start,
      onTap: () => _handleClick(state),
      child: Container(
        color: ((square.fileIndex + square.rank) % 2) != 0
            ? Colors.brown
            : Colors.white,
        child: _squareContent(),
      ),
    );
  }

  void _handleClick(BoardStateNotifier state) {
    // On click of a square containing one of the current players pieces
    bool isCurrentPlayersPiece = square.piece?.isWhite == state.isWhitesMove;
    // No piece is selected and the square does not contain the current players color
    bool hasNoAction = !isCurrentPlayersPiece && !square.isLegalTarget;
    if (hasNoAction) {
      state.selectedSquare = null;
      return;
    }
    if (isCurrentPlayersPiece) {
      state.selectedSquare = square;
      return;
    }
    // If a piece is already selected and the clicked square is a legal target.
    bool validMove = (state.selectedSquare != null) && square.isLegalTarget;
    if (validMove) {
      state.move(target: square);
    }
  }

  Widget? _squareContent() {
    // Empty Square
    if (!square.isLegalTarget && square.piece == null) return null;
    // Occupied square which can be captured by selected piece
    if (square.piece != null) {
      // Occupied square which can't be moved to
      if (!square.isLegalTarget) {
        return square.piece!.figurine();
      } else {
        return Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.green.withOpacity(0.6), width: 4),
                color: Colors.transparent,
              ),
            ),
          ],
        );
      }
    }
    // Empty square which can be occupied by selected piece
    if (square.isLegalTarget && square.piece == null)
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
    ;
  }
}
