part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    print('calculating legal moves');
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
  Widget figurine() => _figurineInternal('P');
}
