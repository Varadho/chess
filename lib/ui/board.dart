import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state.dart';
import 'package:my_own_chess/ui/board_square.dart';

class Board extends StatelessWidget {
  final BoardState boardState = BoardState.newGame();
  Board({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: _calculateSideLength(context),
        width: _calculateSideLength(context),
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: GridView.count(
          physics: null,
          crossAxisCount: 8,
          children: boardState.squares
              .map<Widget>((sq) => BoardSquare(square: sq))
              .toList(),
        ),
      ),
    );
  }

  double _calculateSideLength(BuildContext context) =>
      min(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width) *
      0.85;
}
