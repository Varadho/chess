import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_own_chess/models/board/board_state_notifier.dart';
import 'package:my_own_chess/ui/board.dart';
import 'package:my_own_chess/ui/game_state_display.dart';
import 'package:provider/provider.dart';

import 'models/board/board_state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              BoardStateNotifier(boardState: BoardState.newGame()),
        ),
      ],
      child: ChessApp(),
    ),
  );
}

class ChessApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chess ',
      home: Chess(),
    );
  }
}

class Chess extends StatelessWidget {
  Chess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Board(),
          GameStateDisplay(),
        ],
      ),
    );
  }
}
