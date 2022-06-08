part of 'piece.dart';

class Rook extends Piece {
  Rook({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('R');

  @override
  Rook copyWith({bool? isWhite, bool? isLegalTarget}) => Rook(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final straight in STRAIGHTS) {
      result.addAll(_legalMovesInDirection(boardState, start, straight));
    }
    return result;
  }
}
