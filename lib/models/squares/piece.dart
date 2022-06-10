import 'package:flutter/material.dart';

import '../board/board_state.dart';
import '../board/coordinate.dart';
import '../constants.dart';

part 'bishop.dart';
part 'king.dart';
part 'knight.dart';
part 'pawn.dart';
part 'queen.dart';
part 'rook.dart';
part 'square.dart';

abstract class Piece extends Square {
  bool isWhite;

  Piece({this.isWhite = true, bool isLegalTarget = false})
      : super(isLegalTarget: isLegalTarget);

  List<Coordinate> _possibleMoves(BoardState boardState, Coordinate start);

  @override
  Piece copyWith({bool? isWhite, bool? isLegalTarget});

  List<Coordinate> legalMoves(BoardState boardState, Coordinate start) =>
      _possibleMoves(boardState, start)
          .where(
            (target) => !boardState
                .simulateMove(start, target)
                .isCheck(isWhite: this.isWhite),
          )
          .toList();

  List<Piece> targetPieces(BoardState boardState, Coordinate start) =>
      _piecesFromCoordinates(boardState, _possibleMoves(boardState, start));

  List<Piece> _piecesFromCoordinates(
    BoardState boardState,
    List<Coordinate> coordinates,
  ) =>
      coordinates
          .where((c) => boardState.getPiece(c) != null)
          .map<Piece>((c) => boardState.getPiece(c)!)
          .toList();

  List<Coordinate> _legalMovesInDirection(
    BoardState boardState,
    Coordinate start,
    Vector direction,
  ) {
    final result = <Coordinate>[];
    for (var c = start + direction; c.isOnTheBoard; c += direction) {
      if (boardState.getPiece(c) == null) {
        result.add(c);
        continue;
      }
      if (boardState.getPiece(c)!.isWhite != this.isWhite) {
        result.add(c);
      }
      break;
    }
    return result;
  }

  Widget figurine() => Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isWhite ? Color(0xFFFFFFE8) : Colors.black,
          ),
          child: Center(
            child: Text(
              toString().toUpperCase(),
              style: TextStyle(
                color: isWhite ? Colors.black : Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}
