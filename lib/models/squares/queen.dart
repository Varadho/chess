part of 'piece.dart';

class Queen extends Piece {
  Queen({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('Q');

  @override
  Queen copyWith({bool? isWhite, bool? isLegalTarget}) {
    return Queen(
      isWhite: isWhite ?? this.isWhite,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }

  @override
  List<Coordinate> legalMoves(BoardState boardState, Coordinate square) {
    return [
      ...Bishop(isWhite: isWhite).legalMoves(boardState, square),
      ...Rook(isWhite: isWhite).legalMoves(boardState, square),
    ];
  }
}
