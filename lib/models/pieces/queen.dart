part of 'piece.dart';

class Queen extends Piece {
  Queen({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('Q');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    return [
      ...Bishop().legalMoves(boardState, square),
      ...Rook().legalMoves(boardState, square),
    ];
  }
}
