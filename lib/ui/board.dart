import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board/board_state_notifier.dart';
import '../models/board/coordinate.dart';
import 'board_square.dart';

class Board extends StatelessWidget {
  Board({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final boardState = Provider.of<GameStateNotifier>(context).boardState;
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
        child: GridView.builder(
          reverse: true,
          itemCount: 64,
          shrinkWrap: true,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
          itemBuilder: (context, index) {
            final x = index % 8;
            final y = (index / 8).floor();
            return BoardSquare(
              isWhite: (y - x).isEven,
              square: boardState.squares[y][x],
              coord: Coordinate(x, y),
            );
          },
        ),
      ),
    );
  }

  double _calculateSideLength(BuildContext context) =>
      min(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width,
      ) *
      0.85;
}
