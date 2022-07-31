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
  List<Move> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = HORSEY
        .map<Move>((move) => Move(start: start, target: start + move))
        .where(
          (move) =>
              move.target.isOnTheBoard &&
              (boardState.getPiece(move.target) == null ||
                  boardState.getPiece(move.target)!.isWhite != this.isWhite),
        )
        .toList();
    return result;
  }
}
