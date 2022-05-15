part of 'piece.dart';

class Knight extends Piece {
  Knight({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('N');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
