part of 'piece.dart';

class Rook extends Piece {
  Rook({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('R');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
