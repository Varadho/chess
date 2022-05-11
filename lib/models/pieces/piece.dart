import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_own_chess/models/board/board_state.dart';
import 'package:my_own_chess/models/board/square.dart';

part 'bishop.dart';
part 'king.dart';
part 'knight.dart';
part 'pawn.dart';
part 'queen.dart';
part 'rook.dart';

abstract class Piece {
  bool isWhite;

  List<Square> legalMoves(BoardState boardState, Square square);

  bool isPinned(BoardState boardState, Square square) {
    return true;
  }

  Widget figurine();
  Piece({this.isWhite = true});
}
