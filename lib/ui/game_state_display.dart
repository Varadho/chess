import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:provider/provider.dart';

class GameStateDisplay extends StatelessWidget {
  final TextStyle _textStyle = const TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    BoardStateNotifier state = Provider.of<BoardStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Current player: ${state.isWhitesMove ? 'White' : 'Black'}',
            style: _textStyle,
          ),
          Text(
            'Currently selected: ${state.selectedSquare}',
            style: _textStyle,
          )
        ],
      ),
    );
  }
}
