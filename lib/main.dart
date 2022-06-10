import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/board/board_state.dart';
import 'models/board/board_state_notifier.dart';
import 'ui/board.dart';
import 'ui/game_state_display.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              GameStateNotifier(boardState: BoardState.newGame()),
        ),
      ],
      child: ChessApp(),
    ),
  );
}

class ChessApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Chess ',
        home: Chess(),
      );
}

class Chess extends StatelessWidget {
  Chess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Board(),
            Align(
              alignment: Alignment.topCenter,
              child: GameStateDisplay(),
            ),
          ],
        ),
      );
}
