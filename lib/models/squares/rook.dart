part of 'piece.dart';

class Rook extends Piece {
  Rook({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'R' : 'r';

  @override
  Rook copyWith({bool? isWhite, bool? isLegalTarget}) => Rook(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final straight in STRAIGHTS) {
      result.addAll(_legalMovesInDirection(boardState, start, straight));
    }
    return result;
  }
}
