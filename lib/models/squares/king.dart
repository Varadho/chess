part of 'piece.dart';

class King extends Piece {
  King({bool isWhite = true, bool isLegalTarget = false})
      : super(isWhite: isWhite, isLegalTarget: isLegalTarget);
  @override
  Widget figurine() => _figurineInternal('K');

  @override
  King copyWith({bool? isWhite, bool? isLegalTarget}) => King(
        isWhite: isWhite ?? this.isWhite,
        isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      );

  @override
  List<Coordinate> _legalMoves(BoardState boardState, Coordinate start) {
    final result = <Coordinate>[];
    for (final move in OMNI) {
      final target = start + move;
      if (!target.isOnTheBoard) {
        continue;
      }
      if (boardState.getPiece(target) == null) {
        result.add(target);
        continue;
      }
      if (boardState.getPiece(target)!.isWhite != this.isWhite) {
        result.add(target);
      }
    }
    return result;
  }

  bool _undefended(BoardState boardState, Coordinate loc) {
    // TODO Implement
    throw UnimplementedError();
    // bool defendedByBishop = Bishop(isWhite: isWhite)
    //     .targets(boardState, loc)
    //     .any((piece) =>
    //         (piece is Bishop || piece is Queen) && piece.isWhite != isWhite);
    //
    // bool defendedByRook = Rook(isWhite: isWhite).targets(boardState, loc).any(
    //     (piece) =>
    //         (piece is Rook || piece is Queen) && piece.isWhite != isWhite);
    //
    // bool defendedByKnight = Knight(isWhite: isWhite)
    //     .targets(boardState, loc)
    //     .any((piece) => piece is Knight && piece.isWhite != isWhite);
    // return !(defendedByBishop || defendedByRook || defendedByKnight);
  }
}
