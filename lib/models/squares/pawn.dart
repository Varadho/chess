part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'P' : 'p';

  @override
  Pawn copyWith({bool? isWhite, bool? isLegalTarget}) => Pawn(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Move> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = <Move>[];
    final attacks = this.isWhite
        ? [Vector(-1, 1), Vector(1, 1)]
        : [Vector(-1, -1), Vector(1, -1)];
    final moves = this.isWhite
        ? [Vector(0, 1), Vector(0, 2)]
        : [Vector(0, -1), Vector(0, -2)];

    for (final attack in attacks) {
      final target = start + attack;
      if (!target.isOnTheBoard) {
        continue;
      }

      if (boardState.enPassantTarget == target ||
          boardState.getPiece(target) != null &&
              boardState.getPiece(target)!.isWhite != this.isWhite)
        result.add(Move(start: start, target: target));
    }
    if (boardState.getPiece(start + moves[0]) == null) {
      result.add(Move(start: start, target: start + moves[0]));
      if (start.y == (this.isWhite ? 1 : 6) &&
          boardState.getPiece(start + moves[1]) == null) {
        result.add(Move(start: start, target: start + moves[1]));
      }
    }
    return result;
  }
}
