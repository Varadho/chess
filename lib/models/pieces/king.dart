part of 'piece.dart';

class King extends Piece {
  King({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('K');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    List<Square> legalSquares = [];
    int squareIndex = boardState.squares
        .indexWhere((sq) => sq.rank == square.rank && sq.file == square.file);
    for (int direction in DIRECTIONS) {
      if (squareIndex + direction >= 0 &&
          squareIndex + direction < 64 &&
          (boardState.squares[squareIndex + direction].piece?.isWhite !=
              isWhite) &&
          _undefended(boardState, boardState.squares[squareIndex + direction]))
        legalSquares.add(boardState.squares[squareIndex + direction]);
    }
    return legalSquares;
  }

  bool _undefended(BoardState boardState, Square square) {
    bool defendedByBishop = Bishop(isWhite: isWhite)
        .targets(boardState, square)
        .any((piece) =>
            (piece is Bishop || piece is Queen) && piece.isWhite != isWhite);

    bool defendedByRook = Rook(isWhite: isWhite)
        .targets(boardState, square)
        .any((piece) =>
            (piece is Rook || piece is Queen) && piece.isWhite != isWhite);

    bool defendedByKnight = Knight(isWhite: isWhite)
        .targets(boardState, square)
        .any((piece) => piece is Knight && piece.isWhite != isWhite);

    return !(defendedByBishop || defendedByRook || defendedByKnight);
  }
}
