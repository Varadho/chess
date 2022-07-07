import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        child: SvgPicture.asset(
          '${isWhite ? 'white' : 'black'}_$runtimeType.svg',
          height: 93,
          width: 93,
          fit: BoxFit.fill,
        ),
      );
}
