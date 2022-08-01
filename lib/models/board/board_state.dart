import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../squares/piece.dart';
import 'coordinate.dart';
import 'move.dart';

part 'board_state.g.dart';

@CopyWith()

/// A class to represent any state of a chess board.
/// Besides the 64 squares it also includes the current castling rights
/// as well as the current en passant target coordinate
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

  /// Creates a freshly set up game of chess
  BoardState.newGame()
      : castlingRights = 'KQkq',
        enPassantTarget = null,
        squares = _initialSquares();

  /// Returns the [Piece] which is currently standing on [c].
  /// Returns null if the square is empty.
  Piece? getPiece(Coordinate c) =>
      c.isOnTheBoard && (squares[c.y][c.x] is Piece)
          ? squares[c.y][c.x] as Piece
          : null;

  /// Returns the Coordinate of the square on which the [isWhite] King stands.
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

  /// Helper function which returns the Coordinate for any arbitrary Piece
  /// Works by reference so refrain from using it with newly instantiated Pieces.
  Coordinate findPieceCoordinate(Piece target) {
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        if (squares[i][j] == target) {
          return Coordinate(j, i);
        }
      }
    }
    throw Exception(
      'The ${target.isWhite ? 'white' : 'black'} ${target.runtimeType} went missing!',
    );
  }

  /// A function which returns a new BoardState based on the [move]
  /// This includes transforming the Squares of the board, modifying castling rights,
  /// the en passant target
  BoardState applyMove(Move move) {
    final start = move.start;
    final target = move.target;
    assert(start.isOnTheBoard, 'Start coordinate is NOT on the board');
    assert(target.isOnTheBoard, 'Target coordinate is NOT on the board.');

    final nextSquares = squares.map((subList) => subList.toList()).toList();
    final piece = nextSquares[start.y][start.x] as Piece;
    nextSquares[start.y][start.x] = Square();
    nextSquares[target.y][target.x] = piece;

    var nextCastlingRights = castlingRights;
    var nextEnPassantTarget = null;

    final isWhitesMove = piece.isWhite;
    //TODO Debug and refactor this
    switch (piece.runtimeType) {
      case Pawn:
        //Promoting
        if (target.y == (isWhitesMove ? 7 : 0)) {
          nextSquares[target.y][target.x] = Queen(isWhite: piece.isWhite);
        }
        //Taking en passant
        if (target == enPassantTarget) {
          nextSquares[target.y + (isWhitesMove ? -1 : 1)][target.x] = Square();
        }

        //Setting en passant
        final isMovingTwoSquares =
            target.y - move.start.y == (isWhitesMove ? 2 : -2);
        if (isMovingTwoSquares) {
          nextEnPassantTarget = Coordinate(
            target.x,
            target.y + (isWhitesMove ? -1 : 1),
          );
        }
        break;
      case King:
        if ((target - move.start).dx == 2 &&
            castlingRights.contains(isWhitesMove ? 'K' : 'k')) {
          final rook = getPiece(Coordinate(7, target.y))!;
          nextSquares[target.y][7] = Square();
          nextSquares[target.y][5] = rook;
        }
        if ((target - move.start).dx == -2 &&
            castlingRights.contains(isWhitesMove ? 'Q' : 'q')) {
          final rook = getPiece(Coordinate(0, target.y))!;
          nextSquares[target.y][0] = Square();
          nextSquares[target.y][3] = rook;
        }
        nextCastlingRights = nextCastlingRights
            .replaceFirst(isWhitesMove ? 'K' : 'k', '')
            .replaceFirst(isWhitesMove ? 'Q' : 'q', '');
        break;
      case Rook:
        if (move.start.x == 0 || move.start.x == 7) {
          final kingSide = move.start.x == 7;
          final toBeRemoved;
          if (kingSide) {
            if (isWhitesMove) {
              toBeRemoved = 'K';
            } else {
              toBeRemoved = 'k';
            }
          } else {
            if (isWhitesMove) {
              toBeRemoved = 'Q';
            } else {
              toBeRemoved = 'q';
            }
          }
          nextCastlingRights = nextCastlingRights.replaceFirst(toBeRemoved, '');
        }
        break;
    }

    return copyWith(
      enPassantTarget: nextEnPassantTarget,
      castlingRights: nextCastlingRights,
      squares: nextSquares,
    ).clearLegalMoves();
  }

  // TODO: Think of a nicer way to pass the square to legalMoves
  /// Returns a boolean which indicates whether the [isWhite] Player has any further legal moves
  bool isStalemate({bool isWhite = true}) => !squares.any(
        (file) => file.any(
          (square) =>
              square is Piece &&
              square.isWhite == isWhite &&
              square
                  .legalMoves(this, this.findPieceCoordinate(square))
                  .isNotEmpty,
        ),
      );

  /// Returns a boolean which indicates whether the [isWhite] King is in check.
  bool isCheck({bool isWhite = true}) {
    final start = kingSquare(isWhite: isWhite);

    // If a piece standing on the kingSquare has a target which shares it's attack pattern
    // that piece has a direct line of attack on the king (aka check)
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
    // We use a different approach for the King, because calling isCheck for castling moves creates an infinite loop
    final kingCheck = (kingSquare(isWhite: !isWhite) - start).dx.abs() <= 1 &&
        (kingSquare(isWhite: !isWhite) - start).dy.abs() <= 1;

    return rookCheck || bishopCheck || knightCheck || pawnCheck || kingCheck;
  }

  /// Returns a boolean which indicates whether the [isWhite] King is checkmated.
  bool isCheckmate({bool isWhite = true}) =>
      isCheck(isWhite: isWhite) && isStalemate(isWhite: isWhite);

  /// Display the current [BoardState] with legal moves indicated by a green highlight
  /// accepts any List of coordinates and sets the [isLegalTarget] parameter for the squares of said coordinates
  BoardState displayLegalMoves(List<Move> legalMoves) {
    final resultSquares = squares;
    for (final move
        in legalMoves.map<Coordinate>((move) => move.target).toList()) {
      if (move.isOnTheBoard) {
        resultSquares[move.y][move.x] =
            squares[move.y][move.x].copyWith(isLegalTarget: true);
      }
    }
    return copyWith(squares: resultSquares);
  }

  /// Set the [isLegalTarget] flag on all squares to false
  BoardState clearLegalMoves() => copyWith(
        squares: squares
            .map(
              (ranks) => ranks
                  .map((square) => square.copyWith(isLegalTarget: false))
                  .toList(),
            )
            .toList(),
      );

  /// Board squares with the set-up for a new game.
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
