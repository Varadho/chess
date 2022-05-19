part of 'piece.dart';

class Knight extends Piece {
  Knight({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('N');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    int squareIndex = boardState.squares
        .indexWhere((sq) => sq.rank == square.rank && sq.file == square.file);
    List<Square> legalMoves = [];
    for (int move in KNIGHT_MOVES) {
      int dx = ((squareIndex % 8) - ((squareIndex + move) % 8)).abs();
      int dy = ((squareIndex / 8).floor() - ((squareIndex + move) / 8).floor())
          .abs();
      if (squareIndex + move >= 0 &&
          squareIndex + move < 64 &&
          boardState.squares[squareIndex + move].piece?.isWhite != isWhite &&
          dx * dy == 2) {
        legalMoves.add(boardState.squares[squareIndex + move]);
      }
    }
    return legalMoves;
  }
}
