import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../board/board_state.dart';
import '../board/coordinate.dart';
import '../board/move.dart';
import '../constants.dart';

part 'bishop.dart';
part 'king.dart';
part 'knight.dart';
part 'pawn.dart';
part 'queen.dart';
part 'rook.dart';
part 'square.dart';

/// Abstract class which represents a higher level of support logic for all pieces
abstract class Piece extends Square {
  final bool isWhite;

  Piece({this.isWhite = true, bool isLegalTarget = false})
      : super(isLegalTarget: isLegalTarget);

  /// Calculates a list of possible moves for any given piece, based on their movement pattern.
  /// Concrete implementations to be found in each specific piece class.
  List<Move> _possibleMoves(BoardState boardState, Coordinate start);

  /// Filters all possible moves, so that they don't result in check.
  List<Move> legalMoves(BoardState boardState, Coordinate start) =>
      _possibleMoves(boardState, start)
          .where(
            (move) =>
                !boardState.applyMove(move).isCheck(isWhite: this.isWhite),
          )
          .toList();

  /// Returns all possible targets of a given piece
  List<Piece> targetPieces(BoardState boardState, Coordinate start) =>
      _piecesFromCoordinates(
        boardState,
        _possibleMoves(boardState, start)
            .map<Coordinate>((move) => move.target)
            .toList(),
      );

  /// Looks through a list of given coordinates and returns a List of all pieces which are located on said coordinates
  List<Piece> _piecesFromCoordinates(
    BoardState boardState,
    List<Coordinate> coordinates,
  ) =>
      coordinates
          .where((c) => boardState.getPiece(c) != null)
          .map<Piece>((c) => boardState.getPiece(c)!)
          .toList();

  /// Helper function for pieces which can move "indefinitely" in a given direction
  List<Move> _legalMovesInDirection(
    BoardState boardState,
    Coordinate start,
    Vector direction,
  ) {
    final result = <Move>[];
    for (var c = start + direction; c.isOnTheBoard; c += direction) {
      if (boardState.getPiece(c) == null) {
        result.add(Move(start: start, target: c));
        continue;
      }
      if (boardState.getPiece(c)!.isWhite != this.isWhite) {
        result.add(
          Capture(
            start: start,
            target: c,
            capturedPiece: boardState.getPiece(c)!,
          ),
        );
      }
      break;
    }
    return result;
  }

  /// UI-Representation of a piece
  Widget figurine() => Center(
        child: SvgPicture.asset(
          '${isWhite ? 'white' : 'black'}_$runtimeType.svg',
          height: 93,
          width: 93,
          fit: BoxFit.fill,
        ),
      );
}
