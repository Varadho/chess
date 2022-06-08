part of 'piece.dart';

class Knight extends Piece {
  Knight({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);

  @override
  Widget figurine() => _figurineInternal('N');

  @override
  Knight copyWith({bool? isWhite, bool? isLegalTarget}) => Knight(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) =>
      HORSEY
          .map((move) => start + move)
          .where(
            (move) =>
                move.isOnTheBoard &&
                (boardState.getPiece(move) is! Piece ||
                    boardState.getPiece(move)!.isWhite != this.isWhite),
          )
          .toList();
}
