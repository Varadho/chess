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
        result.add(
          Capture(
            start: start,
            target: target,
            capturedPiece: boardState.getPiece(target)!,
          ),
        );
      }
    }
    // Castling logic
    //Not standing in check
    if (!boardState.isCheck(isWhite: isWhite)) {
      //King side
      if (boardState.castlingRights.contains('${isWhite ? 'K' : 'k'}') &&
          //Squares between king and rook are empty (both are null)
          boardState.getPiece(start + RIGHT) ==
              boardState.getPiece(start + (RIGHT * 2)) &&
          //Not passing through check
          !boardState
              .applyMove(Move(start: start, target: start + RIGHT))
              .isCheck(isWhite: isWhite)) {
        result.add(Move(start: start, target: start + (RIGHT * 2)));
      }
      //Queen side
      if (boardState.castlingRights.contains('${isWhite ? 'Q' : 'q'}') &&
          //Squares between king and rook are empty
          boardState.getPiece(start + LEFT) ==
              boardState.getPiece(start + LEFT * 2) &&
          boardState.getPiece(start + LEFT * 3) == null &&
          //Not moving through check
          !boardState
              .applyMove(Move(start: start, target: start + LEFT))
              .isCheck(isWhite: isWhite) &&
          !boardState
              .applyMove(
                Move(
                  start: start,
                  target: start + (LEFT * 2),
                ),
              )
              .isCheck(isWhite: isWhite)) {
        result.add(Move(start: start, target: start + (LEFT * 2)));
      }
    }
    return result;
  }
}
