part of 'piece.dart';

class Knight extends Piece {
  Knight({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'N' : 'n';

  @override
  Knight copyWith({bool? isWhite, bool? isLegalTarget}) => Knight(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = HORSEY
        .map((move) => start + move)
        .where(
          (move) =>
              move.isOnTheBoard &&
              (boardState.getPiece(move) == null ||
                  boardState.getPiece(move)!.isWhite != this.isWhite),
        )
        .toList();
    return result;
  }
}
