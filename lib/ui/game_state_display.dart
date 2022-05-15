import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:provider/provider.dart';

class GameStateDisplay extends StatelessWidget {
  final TextStyle _textStyle = const TextStyle(fontSize: 24);
  @override
  Widget build(BuildContext context) {
    BoardStateNotifier state = Provider.of<BoardStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current player: ${state.isWhitesMove ? 'White' : 'Black'}',
            style: _textStyle,
          ),
          Text(
            'Currently selected: ${state.selectedSquare?.name ?? 'none'} ${state.selectedSquare?.piece?.runtimeType ?? ''}',
            style: _textStyle,
          )
        ],
      ),
    );
  }
}
