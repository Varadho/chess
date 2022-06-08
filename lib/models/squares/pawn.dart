part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('P');

  @override
  Pawn copyWith({bool? isWhite, bool? isLegalTarget}) => Pawn(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
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
        result.add(target);
    }
    if (boardState.getPiece(start + moves[0]) == null) {
      result.add(start + moves[0]);
      if (start.y == (this.isWhite ? 1 : 6) &&
          boardState.getPiece(start + moves[1]) == null) {
        result.add(start + moves[1]);
      }
    }
    return result;
  }
}
