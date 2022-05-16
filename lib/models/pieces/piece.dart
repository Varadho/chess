import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_own_chess/models/board/board_state.dart';
import 'package:my_own_chess/models/board/square.dart';
import 'package:my_own_chess/models/constants.dart';

part 'bishop.dart';
part 'king.dart';
part 'knight.dart';
part 'pawn.dart';
part 'queen.dart';
part 'rook.dart';

abstract class Piece {
  bool isWhite;

  List<Square> legalMoves(BoardState boardState, Square square);

  bool get isPinned => false;

  Widget figurine();

  Widget _figurineInternal(String src) => Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isWhite ? Color(0xFFFFFFE8) : Colors.black,
          ),
          child: Center(
            child: Text(
              src,
              style: TextStyle(
                color: isWhite ? Colors.black : Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );

  Piece({this.isWhite = true});
}
