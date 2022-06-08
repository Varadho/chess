part of 'piece.dart';

class Bishop extends Piece {
  Bishop({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);
  @override
  Widget figurine() => _figurineInternal('B');

  @override
  Bishop copyWith({bool? isWhite, bool? isLegalTarget}) => Bishop(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final diagonal in DIAGONALS) {
      result.addAll(_legalMovesInDirection(boardState, start, diagonal));
    }
    return result;
  }
}
