part of 'piece.dart';

class King extends Piece {
  King({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'K' : 'k';

  @override
  King copyWith({bool? isWhite, bool? isLegalTarget}) => King(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final move in OMNI) {
      final target = start + move;
      if (!target.isOnTheBoard) {
        continue;
      }
      if (boardState.getPiece(target) == null) {
        result.add(target);
        continue;
      }
      if (boardState.getPiece(target)!.isWhite != this.isWhite) {
        result.add(target);
      }
    }
    return result;
  }
}
