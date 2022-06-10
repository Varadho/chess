import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../squares/piece.dart';
import 'coordinate.dart';

part 'board_state.g.dart';

@CopyWith()
class BoardState extends Equatable {
  /// A List of 64 squares which represents the chess board
  final List<List<Square>> squares;

  /// Indicates the square behind a pawn which just advanced 2 fields.
  final Coordinate? enPassantTarget;

  ///Representation of current castling rights.
  final String castlingRights;

  const BoardState({
    this.enPassantTarget = null,
    this.castlingRights = 'KQkq',
    this.squares = const [],
  });

  BoardState.newGame()
      : castlingRights = 'KQkq',
        enPassantTarget = null,
        squares = _initialSquares();

  Piece? getPiece(Coordinate c) =>
      c.isOnTheBoard && (squares[c.y][c.x] is Piece)
          ? squares[c.y][c.x] as Piece
          : null;

  Coordinate kingSquare({bool isWhite = true}) {
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        if (squares[i][j] is King &&
            (squares[i][j] as King).isWhite == isWhite) {
          return Coordinate(j, i);
        }
      }
    }
    throw Exception('The ${isWhite ? 'white' : 'black'} King went missing!');
  }

  BoardState simulateMove(Coordinate start, Coordinate target) {
    final newSquares = squares.map((subList) => subList.toList()).toList();
    final piece = newSquares[start.y][start.x] as Piece;
    newSquares[start.y][start.x] = Square();
    newSquares[target.y][target.x] = piece;
    return copyWith(squares: newSquares);
  }

  bool isCheck({bool isWhite = true}) {
    final start = kingSquare(isWhite: isWhite);

    final rookCheck = Rook(isWhite: isWhite)
        .targetPieces(this, start)
        .any((piece) => piece is Rook || piece is Queen);

    final bishopCheck = Bishop(isWhite: isWhite)
        .targetPieces(this, start)
        .any((piece) => piece is Bishop || piece is Queen);

    final knightCheck = Knight(isWhite: isWhite)
        .targetPieces(this, start)
        .any((piece) => piece is Knight);

    final pawnCheck = Pawn(isWhite: isWhite)
        .targetPieces(this, start)
        .any((piece) => piece is Pawn);

    final kingCheck = King(isWhite: isWhite)
        .targetPieces(this, start)
        .any((piece) => piece is King);

    return rookCheck || bishopCheck || knightCheck || pawnCheck || kingCheck;
  }

  BoardState showLegalMoves(List<Coordinate> legalMoves) {
    final resultSquares = squares;
    for (final move in legalMoves) {
      resultSquares[move.y][move.x] =
          squares[move.y][move.x].copyWith(isLegalTarget: true);
    }
    return copyWith(squares: resultSquares);
  }

  BoardState clearLegalMoves() => copyWith(
        squares: squares
            .map(
              (ranks) => ranks
                  .map((square) => square.copyWith(isLegalTarget: false))
                  .toList(),
            )
            .toList(),
      );

  static List<List<Square>> _initialSquares() => <List<Square>>[
        // Black Pieces
        [
          Rook(isWhite: false),
          Knight(isWhite: false),
          Bishop(isWhite: false),
          Queen(isWhite: false),
          King(isWhite: false),
          Bishop(isWhite: false),
          Knight(isWhite: false),
          Rook(isWhite: false)
        ],
        [for (int i = 0; i < 8; i++) Pawn(isWhite: false)],
        //Empty Squares
        for (int i = 3; i <= 6; i++)
          [
            for (int j = 0; j < 8; j++) Square(),
          ],
        //White Pieces
        [for (int i = 0; i < 8; i++) Pawn()],
        [
          Rook(),
          Knight(),
          Bishop(),
          Queen(),
          King(),
          Bishop(),
          Knight(),
          Rook()
        ],
      ].reversed.toList();

  @override
  String toString() {
    final result = StringBuffer();
    squares.reversed.forEach((rank) {
      result.write('$rank\n');
    });
    result
      ..write('$castlingRights ')
      ..write('$enPassantTarget ')
      ..write('isCheck: ${isCheck() || isCheck(isWhite: false)}');
    return result.toString();
  }

  @override
  List<Object?> get props => [enPassantTarget, castlingRights, squares];
}
