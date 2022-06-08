part of 'piece.dart';

class Pawn extends Piece {
  Pawn({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('P');

  @override
  Pawn copyWith({bool? isWhite, bool? isLegalTarget}) {
    return Pawn(
      isWhite: isWhite ?? this.isWhite,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }

  // TODO Clean this up
  @override
  List<Coordinate> legalMoves(BoardState boardState, Coordinate start) {
    // TODO Implement this
    throw UnimplementedError();
    // List<Square> legalSquares = [];
    // // if (_isPinned(boardState, start)) return legalSquares;
    // if (isWhite) {
    //   //Check if squares ahead are empty
    //   if (boardState.getPiece(start.file, start.rank + 1) == null) {
    //     legalSquares.add(start.copyWith(rank: start.rank + 1));
    //     //Nested, because if the square ahead is blocked we don't need to check for the next one.
    //     if (start.rank == 2 &&
    //         boardState.getPiece(start.file, start.rank + 2) == null) {
    //       legalSquares.add(start.copyWith(rank: start.rank + 2));
    //     }
    //   }
    //
    //   //Check if diagonal squares can be captured
    //   if (start.fileIndex < 7 &&
    //       !(boardState
    //               .getPiece(FILES[start.fileIndex + 1], start.rank + 1)
    //               ?.isWhite ??
    //           true))
    //     // ^ ||'${FILES[start.fileIndex + 1]}${start.rank + 1}' == boardState.enPassantTarget
    //     legalSquares.add(
    //       start.copyWith(
    //         file: FILES[start.fileIndex + 1],
    //         rank: start.rank + 1,
    //       ),
    //     );
    //   if (start.fileIndex > 0 &&
    //       !(boardState
    //               .getPiece(FILES[start.fileIndex - 1], start.rank + 1)
    //               ?.isWhite ??
    //           true))
    //     legalSquares.add(
    //       start.copyWith(
    //         file: FILES[start.fileIndex - 1],
    //         rank: start.rank + 1,
    //       ),
    //     );
    // } else {
    //   //Check if squares ahead are empty
    //   if (boardState.getPiece(start.file, start.rank - 1) == null) {
    //     legalSquares.add(start.copyWith(rank: start.rank - 1));
    //     //Nested, because if the square ahead is blocked we don't need to check for the next one.
    //     if (start.rank == 7 &&
    //         boardState.getPiece(start.file, start.rank - 2) == null) {
    //       legalSquares.add(start.copyWith(rank: start.rank - 2));
    //     }
    //   }
    //
    //   //Check if diagonal squares can be captured
    //   if (start.fileIndex < 7 &&
    //       (boardState
    //               .getPiece(FILES[start.fileIndex + 1], start.rank - 1)
    //               ?.isWhite ??
    //           false))
    //     // ^ ||'${FILES[start.fileIndex + 1]}${start.rank + 1}' == boardState.enPassantTarget
    //     legalSquares.add(
    //       start.copyWith(
    //         file: FILES[start.fileIndex + 1],
    //         rank: start.rank - 1,
    //       ),
    //     );
    //   if (start.fileIndex > 0 &&
    //       (boardState
    //               .getPiece(FILES[start.fileIndex - 1], start.rank - 1)
    //               ?.isWhite ??
    //           false))
    //     legalSquares.add(
    //       start.copyWith(
    //         file: FILES[start.fileIndex - 1],
    //         rank: start.rank - 1,
    //       ),
    //     );
    // }
    // return legalSquares;
  }
}
