part of 'piece.dart';

class King extends Piece {
  King({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  String toString() => isWhite ? 'K' : 'k';

  @override
  King copyWith({bool? isWhite, bool? isLegalTarget}) => King(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Move> _possibleMoves(BoardState boardState, Coordinate start) {
    final result = <Move>[];
    for (final move in OMNI) {
      final target = start + move;
      if (!target.isOnTheBoard) {
        continue;
      }
      if (boardState.getPiece(target) == null) {
        result.add(Move(start: start, target: target));
        continue;
      }
      if (boardState.getPiece(target)!.isWhite != this.isWhite) {
        result.add(Move(start: start, target: target));
      }
    }
    if (!boardState.isCheck(isWhite: isWhite)) {
      //King side
      if (boardState.castlingRights.contains('${isWhite ? 'K' : 'k'}') &&
          //Squares between king and rook are empty (both are null)
          boardState.getPiece(start + Vector(1, 0)) ==
              boardState.getPiece(start + Vector(2, 0)) &&
          //Not standing in or moving through check
          // !boardState.simulateMove(start, start).isCheck(isWhite: isWhite) &&
          !boardState
              .applyMove(Move(start: start, target: start + Vector(1, 0)))
              .isCheck(isWhite: isWhite)) {
        result.add(Move(start: start, target: start + Vector(2, 0)));
      }
      //Queen side
      if (boardState.castlingRights.contains('${isWhite ? 'Q' : 'q'}') &&
          //Squares between king and rook are empty
          boardState.getPiece(start + Vector(-1, 0)) ==
              boardState.getPiece(start + Vector(-2, 0)) &&
          boardState.getPiece(start + Vector(-3, 0)) == null &&
          //Not standing in or moving through check
          // !boardState.simulateMove(start, start).isCheck(isWhite: isWhite) &&
          !boardState
              .applyMove(Move(start: start, target: start + Vector(-1, 0)))
              .isCheck(isWhite: isWhite) &&
          !boardState
              .applyMove(
                Move(
                  start: start,
                  target: start + Vector(-2, 0),
                ),
              )
              .isCheck(isWhite: isWhite)) {
        result.add(Move(start: start, target: start + Vector(-2, 0)));
      }
    }

    return result;
  }
}
