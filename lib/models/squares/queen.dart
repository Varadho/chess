part of 'piece.dart';

class Queen extends Piece {
  Queen({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'Q' : 'q';

  @override
  Queen copyWith({bool? isWhite, bool? isLegalTarget}) => Queen(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Move> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = <Move>[];
    for (final direction in OMNI) {
      result.addAll(_legalMovesInDirection(boardState, start, direction));
    }
    return result;
  }
}
