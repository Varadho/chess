part of 'piece.dart';

class Bishop extends Piece {
  Bishop({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);
  @override
  Widget figurine() => _figurineInternal('B');

  @override
  Bishop copyWith({bool? isWhite, bool? isLegalTarget}) {
    return Bishop(
      isWhite: isWhite ?? this.isWhite,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }

  @override
  List<Coordinate> legalMoves(BoardState boardState, Coordinate start) {
    //TODO Implement this
    throw UnimplementedError();
    // List<Square> legalSquares = [];
    //
    // // if(_isPinned(boardState, square)) return legalSquares;
    // int rank = square.rank;
    // int file = square.fileIndex;
    // //Check NE Diagonal
    // while (rank <= 8 && file < 7) {
    //   Piece? piece = boardState.getPiece(FILES[++file], ++rank);
    //   if (piece == null) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(Square(FILES[file], rank, piece: piece));
    //     break;
    //   }
    // }
    //
    // rank = square.rank;
    // file = square.fileIndex;
    // //Check SE Diagonal
    // while (rank >= 1 && file < 7) {
    //   Piece? piece = boardState.getPiece(FILES[++file], --rank);
    //   if (piece == null) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     break;
    //   }
    // }
    //
    // rank = square.rank;
    // file = square.fileIndex;
    // //Check SW Diagonal
    // while (rank >= 1 && file > 0) {
    //   Piece? piece = boardState.getPiece(FILES[--file], --rank);
    //   if (piece == null) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     break;
    //   }
    // }
    // rank = square.rank;
    // file = square.fileIndex;
    // //Check NW Diagonal
    // while (rank <= 8 && file > 0) {
    //   Piece? piece = boardState.getPiece(FILES[--file], ++rank);
    //   if (piece == null) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(Square(FILES[file], rank));
    //     break;
    //   }
    // }
    //
    // return legalSquares;
  }
}
