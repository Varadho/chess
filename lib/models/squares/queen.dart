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
    final possibleMoves = <Move>[];
    for (final direction in OMNI) {
      possibleMoves.addAll(_legalMovesInDirection(boardState, start, direction));
    }
    return possibleMoves;
  }
}
