import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/board/game_state_notifier.dart';

class GameStateDisplay extends StatelessWidget {
  final TextStyle _textStyle =
      const TextStyle(fontSize: 24, color: Colors.black);
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<GameStateNotifier>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                surfaceTintColor: Colors.transparent,
                enableFeedback: false,
                side: BorderSide(),
              ),
              child: Text(
                'New Game',
                style: _textStyle,
              ),
              onPressed: () =>
                  Provider.of<GameStateNotifier>(context, listen: false)
                      .resetGame(),
            ),
          ),
          Text(
            'Current player: ${state.isWhitesMove ? 'White' : 'Black'}',
            style: _textStyle,
          ),
          //
          // Container(
          //   decoration: BoxDecoration(border: Border.all()),
          //   child: SizedBox(
          //     width: 145,
          //     height: 280,
          //     child: ListView.separated(
          //       shrinkWrap: true,
          //       itemCount: ((state.boardStates.length - 1) / 2).ceil(),
          //       itemBuilder: (context, index) => Row(
          //         children: [
          //           Text((index + 1).toString().padLeft(3)),
          //           TextButton(
          //             onPressed: () {
          //               state.selectedBoardStateIndex = index * 2;
          //             },
          //             child: Text(
          //               state.boardStates[index * 2 + 1].castlingRights,
          //             ),
          //           ),
          //           if ((index * 2 + 2) < state.boardStates.length)
          //             TextButton(
          //               onPressed: () {
          //                 state.selectedBoardStateIndex = index * 2 + 1;
          //               },
          //               child: Text(
          //                 state.boardStates[index * 2 + 2].castlingRights,
          //               ),
          //             )
          //         ],
          //       ),
          //       separatorBuilder: (context, index) => Divider(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
