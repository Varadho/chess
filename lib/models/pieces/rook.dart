part of 'piece.dart';

class Rook extends Piece {
  Rook({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget image() => Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isWhite ? Color(0xFFFFFFE8) : Colors.black,
          ),
          child: Center(
            child: Text(
              'R',
              style: TextStyle(
                color: isWhite ? Colors.black : Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    // TODO: implement legalMoves
    throw UnimplementedError();
  }
}
