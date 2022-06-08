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

  @override
  Piece copyWith({bool? isWhite, bool? isLegalTarget});

  List<Piece> targets(BoardState boardState, Coordinate start) =>
      piecesFromCoordinates(boardState, _legalMoves(boardState, start));

  List<Piece> piecesFromCoordinates(
    BoardState boardState,
    List<Coordinate> coordinates,
  ) =>
      coordinates
          .where((c) => boardState.squares[c.y][c.x] is Piece)
          .map<Piece>((c) => boardState.squares[c.y][c.x] as Piece)
          .toList();

  List<Coordinate> legalMoves(BoardState boardState, Coordinate start) =>
      _legalMoves(boardState, start)
        ..retainWhere(
          (coord) => pinnedMoves(boardState, start).contains(coord),
        );

  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start);

  List<Coordinate> _legalMovesInDirection(
    BoardState boardState,
    Coordinate start,
    Vector direction,
  ) {
    final result = <Coordinate>[];
    for (var c = start; c.isOnTheBoard; c += direction) {
      if (boardState.getPiece(c) == this) {
        continue;
      }
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

  List<Coordinate> pinnedMoves(BoardState boardState, Coordinate start) {
    final result = _legalMoves(boardState, start);
    if (boardState.getPiece(start) is King) {
      return result;
    }

    for (final diagonal in DIAGONALS) {
      final movesInDirection =
          _legalMovesInDirection(boardState, start, diagonal);

      if (piecesFromCoordinates(boardState, movesInDirection)
          .any((piece) => piece is Bishop || piece is Queen)) {
        var c = start;
        var isPinned = false;
        final movesInOppositeDirection = [];

        while (c.isOnTheBoard) {
          if (boardState.squares[c.y][c.x] is Piece) {
            if ((boardState.squares[c.y][c.x] as Piece).isWhite == isWhite) {
              if (boardState.squares[c.y][c.x] is King) {
                isPinned = true;
              }
              break;
            }
            movesInOppositeDirection.add(c);
            break;
          }
          movesInOppositeDirection.add(c);
          c += diagonal * -1;
        }

        if (isPinned) {
          result.retainWhere(
            (coordinate) => [...movesInDirection, ...movesInOppositeDirection]
                .contains(coordinate),
          );
        }
      }
    }

    for (final straight in STRAIGHTS) {
      final movesInDirection =
          _legalMovesInDirection(boardState, start, straight);

      if (piecesFromCoordinates(boardState, movesInDirection)
          .any((piece) => piece is Bishop || piece is Queen)) {
        var c = start;
        var isPinned = false;
        final movesInOppositeDirection = [];

        while (c.isOnTheBoard) {
          if (boardState.squares[c.y][c.x] is Piece) {
            if ((boardState.squares[c.y][c.x] as Piece).isWhite == isWhite) {
              if (boardState.squares[c.y][c.x] is King) {
                isPinned = true;
              }
              break;
            }
            movesInOppositeDirection.add(c);
            break;
          }
          movesInOppositeDirection.add(c);
          c += straight * -1;
        }

        if (isPinned) {
          result.retainWhere(
            (coordinate) => [...movesInDirection, ...movesInOppositeDirection]
                .contains(coordinate),
          );
        }
      }
    }

    return result;
  }
}
