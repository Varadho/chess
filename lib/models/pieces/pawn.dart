part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    bool hasMoved =
        (isWhite && square.rank == 2) || (!isWhite && square.rank == 7);
    return [
      Square('e', 4, isLegalTarget: true),
      Square('e', 3, isLegalTarget: true),
    ];
  }

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
              'P',
              style: TextStyle(
                color: isWhite ? Colors.black : Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
}
