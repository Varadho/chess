import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_own_chess/models/board/board_state.dart';
import 'package:my_own_chess/models/board/coordinate.dart';
import 'package:my_own_chess/models/squares/square.dart';

part 'bishop.dart';
part 'king.dart';
part 'knight.dart';
part 'pawn.dart';
part 'queen.dart';
part 'rook.dart';

abstract class Piece extends Square {
  bool isWhite;

  List<Coordinate> legalMoves(BoardState boardState, Coordinate start);

  List<Coordinate> targets(BoardState boardState, Coordinate start) {
    List<Coordinate> targetPieces = [];
    legalMoves(boardState, start).forEach((sq) {
      if (sq is Piece) targetPieces.add(sq);
    });
    return targetPieces;
  }

  bool _isPinned(BoardState boardState, int file, int rank) {
    //TODO Implement this
    throw UnimplementedError();
  }

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

  Piece({this.isWhite = true, bool isLegalTarget = false})
      : super(isLegalTarget: isLegalTarget);

  @override
  Piece copyWith({bool? isWhite, bool? isLegalTarget});
}
