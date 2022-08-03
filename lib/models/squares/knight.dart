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
    final possibleMoves = HORSEY
        .map<Move>(
          (direction) => boardState.getPiece(start + direction) == null
              ? Move(start: start, target: start + direction)
              : Capture(
                  start: start,
                  target: start + direction,
                  capturedPiece: boardState.getPiece(start + direction)!,
                ),
        )
        .where(
          (move) =>
              move.target.isOnTheBoard &&
              (boardState.getPiece(move.target) == null ||
                  boardState.getPiece(move.target)!.isWhite != this.isWhite),
        )
        .toList();
    return possibleMoves;
  }
}
