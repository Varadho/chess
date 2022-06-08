part of 'piece.dart';

class Knight extends Piece {
  Knight({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('N');

  @override
  Knight copyWith({bool? isWhite, bool? isLegalTarget}) {
    return Knight(
      isWhite: isWhite ?? this.isWhite,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }

  @override
  List<Coordinate> legalMoves(BoardState boardState, Coordinate start) {
    List<Coordinate> result = [];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (((i - start.x) * (j - start.y)).abs() == 2) {
          if (boardState.squares[i][j] is Piece &&
              (boardState.squares[i][j] as Piece).isWhite == this.isWhite)
            continue;
          result.add(Coordinate(i, j));
        }
      }
    }
    return result;
  }
}
