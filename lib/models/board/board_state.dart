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

  /// Standard constructor for the BoardState class
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

  /// Creates a freshly set up game of chess
  BoardState.queenEndgame()
      : castlingRights = '',
        enPassantTarget = null,
        squares = _queenEndgameSquares();

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
        if (squares[j][i] == target) {
          return Coordinate(i, j);
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

    //Additional Board manipulation like: castling, promoting, enPassant
    switch (piece.runtimeType) {
      case Pawn:
        nextEnPassantTarget =
            _handlePawnMove(move, isWhitesMove, nextSquares, piece);
        break;
      case King:
        nextCastlingRights =
            _handleKingMove(move, isWhitesMove, nextSquares, piece);
        break;
      case Rook:
        nextCastlingRights =
            _handleRookMove(move, isWhitesMove, nextSquares, piece);
        break;
    }

    return copyWith(
      enPassantTarget: nextEnPassantTarget,
      castlingRights: nextCastlingRights,
      squares: nextSquares,
    ).clearLegalMoves();
  }

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

  /// Returns a boolean which indicates whether the [isWhite] Player has any further legal moves
  bool isStalemate({bool isWhite = true}) =>
      !squares.any(
        (file) => file.any(
          (square) =>
              square is Piece &&
              square.isWhite == isWhite &&
              square
                  .legalMoves(this, this.findPieceCoordinate(square))
                  .isNotEmpty,
        ),
      )
      // TODO WTF WHY DOES THIS BREAK THE [findPieceCoordinate] CALL?!
      ||
      isInsufficientMaterial();

  /// Returns a boolean which indicates whether the [isWhite] King is checkmated.
  bool isCheckmate({bool isWhite = true}) =>
      isCheck(isWhite: isWhite) && isStalemate(isWhite: isWhite);

  /// Function to determine if there is enough material on the Board for one player to checkmate the other.
  bool isInsufficientMaterial() {
    final pieces = squares
        .reduce(
          (file, rank) => file..addAll(rank),
        )
        .where((square) => square is Piece)
        .toList();
    final canForceMate =
        pieces.any((piece) => piece is Pawn || piece is Queen || piece is Rook);

    final numberOfKnightsAndBishops = pieces.fold<int>(
      0,
      (previousValue, element) => element is Knight || element is Bishop
          ? previousValue++
          : previousValue,
    );
    // This is not 100% accurate, since theoretically both players could have a
    // single bishop and the game would continue.
    return !(canForceMate || (numberOfKnightsAndBishops >= 2));
  }

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
        // Black pawns
        [for (int i = 0; i < 8; i++) Pawn(isWhite: false)],
        //Empty Squares
        for (int i = 3; i <= 6; i++)
          [
            for (int j = 0; j < 8; j++) Square(),
          ],
        //White Pawns
        [for (int i = 0; i < 8; i++) Pawn()],
        //White Pieces
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

  /// BoardSquares with a King and Queen for each side, simulating a Queen-endgame
  static List<List<Square>> _queenEndgameSquares() => <List<Square>>[
        // Black Pieces
        [
          for (int i = 0; i < 3; i++) Square(),
          King(isWhite: false),
          Queen(isWhite: false),
          for (int i = 0; i < 3; i++) Square(),
        ],
        //Empty Squares
        for (int i = 2; i <= 7; i++)
          [
            for (int j = 0; j < 8; j++) Square(),
          ],
        //White Pieces
        [
          for (int i = 0; i < 3; i++) Square(),
          King(),
          Queen(),
          for (int i = 0; i < 3; i++) Square(),
        ],
      ].reversed.toList();

  @override
  List<Object?> get props => [enPassantTarget, castlingRights, squares];

  /// Helper function to modify boardState other than moving or simply capturing a piece.
  /// For Pawns this includes promotion, taking enPassant, and setting enPassant.
  /// The return value is a Coordinate which represents the next enPassant target.
  Coordinate? _handlePawnMove(
    Move move,
    bool isWhitesMove,
    List<List<Square>> squares,
    Piece piece,
  ) {
    final target = move.target;
    final start = move.start;
    //Promoting
    if (target.y == (isWhitesMove ? 7 : 0)) {
      squares[target.y][target.x] = Queen(isWhite: piece.isWhite);
    }
    //Taking en passant
    if (target == enPassantTarget) {
      squares[target.y + (isWhitesMove ? -1 : 1)][target.x] = Square();
    }

    //Setting en passant
    final isMovingTwoSquares = target.y - start.y == (isWhitesMove ? 2 : -2);
    if (isMovingTwoSquares) {
      return Coordinate(
        target.x,
        target.y + (isWhitesMove ? -1 : 1),
      );
    }
    return null;
  }

  /// Helper function to modify boardState further than moving pieces.
  /// For the King this includes performing a castling move and setting the respective castling rights.
  /// The return value is the modified castling rights.
  String _handleKingMove(
    Move move,
    bool isWhitesMove,
    List<List<Square>> squares,
    Piece piece,
  ) {
    final target = move.target;
    final start = move.start;
    // Castling kingside
    if ((target - start).dx == 2 &&
        castlingRights.contains(isWhitesMove ? 'K' : 'k')) {
      final rook = getPiece(Coordinate(7, target.y))!;
      squares[target.y][7] = Square();
      squares[target.y][5] = rook;
    }
    // Castling queenside
    if ((target - start).dx == -2 &&
        castlingRights.contains(isWhitesMove ? 'Q' : 'q')) {
      final rook = getPiece(Coordinate(0, target.y))!;
      squares[target.y][0] = Square();
      squares[target.y][3] = rook;
    }
    //Remove all castling rights after the king moved.
    return castlingRights
        .replaceFirst(isWhitesMove ? 'K' : 'k', '')
        .replaceFirst(isWhitesMove ? 'Q' : 'q', '');
  }

  /// Helper function to modify boardState further than moving pieces.
  /// For the Rook this includes setting the respective castling rights, once it moves.
  /// The return value is the modified castling rights.
  String _handleRookMove(
    Move move,
    bool isWhitesMove,
    List<List<Square>> squares,
    Piece piece,
  ) {
    final start = move.start;
    if (start.x == 0 || start.x == 7) {
      final kingSide = start.x == 7;
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
      return castlingRights.replaceFirst(toBeRemoved, '');
    }
    return castlingRights;
  }
}
