part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    print('calculating mvoes');
    return [
      boardState.squares.firstWhere((ahead) {
        if (isWhite) {
          return ahead.rank == square.rank + 1 && ahead.file == square.file;
        } else {
          return ahead.rank == square.rank - 1 && ahead.file == square.file;
        }
      })
    ];
  }

  @override
  Widget figurine() => Center(
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
