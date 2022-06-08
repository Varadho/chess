part of 'piece.dart';

class Queen extends Piece {
  Queen({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('Q');

  @override
  Queen copyWith({bool? isWhite, bool? isLegalTarget}) => Queen(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final direction in OMNI) {
      result.addAll(_legalMovesInDirection(boardState, start, direction));
    }
    return result;
  }
}
