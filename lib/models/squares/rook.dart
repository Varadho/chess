part of 'piece.dart';

class Rook extends Piece {
  Rook({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('R');

  @override
  Rook copyWith({bool? isWhite, bool? isLegalTarget}) {
    return Rook(
      isWhite: isWhite ?? this.isWhite,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }

  @override
  List<Coordinate> legalMoves(BoardState boardState, Coordinate square) {
    // TODO Implement this
    throw UnimplementedError();
    // List<Square> legalSquares = [];
    //
    // //Check ranks
    // int rank = square.rank;
    // //Check ranks above
    // while (rank <= 8) {
    //   Piece? piece = boardState.getPiece(square.file, ++rank);
    //   if (piece == null) {
    //     legalSquares.add(square.copyWith(rank: rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(square.copyWith(rank: rank));
    //     break;
    //   }
    // }
    //
    // rank = square.rank;
    // //Check ranks below
    // while (rank >= 1) {
    //   Piece? piece = boardState.getPiece(square.file, --rank);
    //   if (piece == null) {
    //     legalSquares.add(square.copyWith(rank: rank));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(square.copyWith(rank: rank));
    //     break;
    //   }
    // }
    //
    // //Check files
    // int file = square.fileIndex;
    // //Check files to the right
    // while (file < 7) {
    //   Piece? piece = boardState.getPiece(FILES[++file], square.rank);
    //   if (piece == null) {
    //     legalSquares.add(square.copyWith(file: FILES[file]));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(square.copyWith(file: FILES[file]));
    //     break;
    //   }
    // }
    //
    // file = square.fileIndex;
    // //Check files to the left
    // while (file > 0) {
    //   Piece? piece = boardState.getPiece(FILES[--file], square.rank);
    //   if (piece == null) {
    //     legalSquares.add(square.copyWith(file: FILES[file]));
    //     continue;
    //   }
    //   if (piece.isWhite == isWhite) break;
    //   if (piece.isWhite != isWhite) {
    //     legalSquares.add(square.copyWith(file: FILES[file]));
    //     break;
    //   }
    // }
    //
    // return legalSquares;
  }
}
