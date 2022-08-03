part of 'piece.dart';

class Bishop extends Piece {
  Bishop({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'B' : 'b';

  @override
  Bishop copyWith({bool? isWhite, bool? isLegalTarget}) => Bishop(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Move> _possibleMoves(BoardState boardState, Coordinate start) {
    final possibleMoves = <Move>[];
    for (final diagonal in DIAGONALS) {
      possibleMoves.addAll(_legalMovesInDirection(boardState, start, diagonal));
    }
    return possibleMoves;
  }
}
