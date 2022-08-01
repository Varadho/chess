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
    final moves = this.isWhite ? [UP, UP * 2] : [DOWN, DOWN * 2];

    for (final attack in attacks) {
      final target = start + attack;
      if (!target.isOnTheBoard) {
        continue;
      }
      if (boardState.enPassantTarget == target ||
          (boardState.getPiece(target)?.isWhite ?? isWhite) == !isWhite)
        result.add(
          Capture(
            //getPiece(target) can return null when capturing en passant
            capturedPiece:
                boardState.getPiece(target) ?? Pawn(isWhite: !isWhite),
            start: start,
            target: target,
          ),
        );
    }
    for (final move in moves) {
      final target = start + move;
      if (boardState.getPiece(target) == null) {
        result.add(Move(start: start, target: target));
      }
      if (start.y != (this.isWhite ? 1 : 6)) {
        break;
      }
    }
    return result;
  }
}
