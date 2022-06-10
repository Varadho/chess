import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board/board_state_notifier.dart';
import '../models/board/coordinate.dart';

class GameStateDisplay extends StatelessWidget {
  final TextStyle _textStyle =
      const TextStyle(fontSize: 24, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Current player: ${state.isWhitesMove ? 'White' : 'Black'}',
                style: _textStyle,
              ),
              Text(
                'Currently selected: ${state.boardState.getPiece(state.selectedCoord ?? Coordinate(0, 0)).runtimeType}',
                style: _textStyle,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(),
              ),
              child: Text(
                'Reset',
                style: _textStyle,
              ),
              onPressed: () =>
                  Provider.of<GameStateNotifier>(context, listen: false)
                      .resetGame(),
            ),
          ),
        ],
      ),
    );
  }
}
