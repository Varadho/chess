part of 'piece.dart';

class Bishop extends Piece {
  Bishop({bool isWhite = true}) : super(isWhite: isWhite);

  @override
  Widget figurine() => _figurineInternal('B');

  @override
  List<Square> legalMoves(BoardState boardState, Square square) {
    List<Square> legalSquares = [];

    //Check ranks
    int rank = square.rank;
    int file = square.fileIndex;
    //Check NE Diagonal
    while (rank <= 8 && file < 7) {
      Piece? piece = boardState.getPiece(FILES[++file], ++rank);
      if (piece == null) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        continue;
      }
      if (piece.isWhite == isWhite) break;
      if (piece.isWhite != isWhite) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        break;
      }
    }

    rank = square.rank;
    file = square.fileIndex;
    //Check SE Diagonal
    while (rank >= 1 && file < 7) {
      Piece? piece = boardState.getPiece(FILES[++file], --rank);
      if (piece == null) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        continue;
      }
      if (piece.isWhite == isWhite) break;
      if (piece.isWhite != isWhite) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        break;
      }
    }

    rank = square.rank;
    file = square.fileIndex;
    //Check SW Diagonal
    while (rank >= 1 && file > 0) {
      Piece? piece = boardState.getPiece(FILES[--file], --rank);
      if (piece == null) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        continue;
      }
      if (piece.isWhite == isWhite) break;
      if (piece.isWhite != isWhite) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        break;
      }
    }
    rank = square.rank;
    file = square.fileIndex;
    //Check NW Diagonal
    while (rank <= 8 && file > 0) {
      Piece? piece = boardState.getPiece(FILES[--file], ++rank);
      if (piece == null) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        continue;
      }
      if (piece.isWhite == isWhite) break;
      if (piece.isWhite != isWhite) {
        legalSquares.add(square.copyWith(file: FILES[file], rank: rank));
        break;
      }
    }

    return legalSquares;
  }
}
