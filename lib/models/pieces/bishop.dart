part of 'piece.dart';

class Bishop extends Piece {
  Bishop({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('B');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
