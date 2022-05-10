import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:my_own_chess/models/board/square.dart';
import 'package:provider/provider.dart';

class BoardSquare extends StatelessWidget {
  final Square square;
  BoardSquare({Key? key, required this.square}) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        dragStartBehavior: DragStartBehavior.start,
        onTap: () => _handleClick(context),
        child: Container(
          color: ((square.fileIndex + square.rank) % 2) != 0
              ? Colors.brown
              : Colors.white,
          child: _squareContent(),
        ),
      );

  void _handleClick(BuildContext context) {
    BoardStateNotifier state =
        Provider.of<BoardStateNotifier>(context, listen: false);
    // On click of a square containing one of the current players pieces
    bool isSelectingPiece = square.piece?.isWhite == state.isWhitesMove;
    // No piece is selected and the square does not contain the current players color
    bool hasNoAction = !isSelectingPiece && !square.isLegalTarget;
    if (hasNoAction) {
      state.selectedSquare = null;
      return;
    }
    if (isSelectingPiece) {
      state.selectedSquare = square;
      return;
    }
    // If a piece is already selected and the clicked square is a legal target.
    bool validMove = state.selectedSquare != null && square.isLegalTarget;
    if (validMove) {
      state.move(target: square);
    }
  }

  Widget? _squareContent() {
    // Empty Square
    if (!square.isLegalTarget && square.piece == null) return null;
    // Occupied square which can be captured by selected piece
    if (square.isLegalTarget && square.piece != null)
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green.withOpacity(0.7))),
          ),
          square.piece?.image() ?? Container()
        ],
      );
    // Empty square which can be occupied by selected piece
    if (square.isLegalTarget && square.piece == null)
      return Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.circular(50),
        ),
      );
    // Occupied square which can't be moved to
    if (!square.isLegalTarget && square.piece != null)
      return square.piece?.image();
  }
}
