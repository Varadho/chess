part of 'piece.dart';

class Queen extends Piece {
  Queen({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('Q');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
