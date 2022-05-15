part of 'piece.dart';

class King extends Piece {
  King({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('K');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
