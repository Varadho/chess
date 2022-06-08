import 'package:my_own_chess/models/board/coordinate.dart';
import 'package:my_own_chess/models/squares/piece.dart';
import 'package:my_own_chess/models/squares/square.dart';

class BoardState {
  /// A List of 64 squares which represents the chess board
  final List<List<Square>> squares;

  /// Indicates the square behind a pawn which just advanced 2 fields.
  final String enPassantTarget;

  ///Representation of current castling rights.
  final String castlingRights;

  factory BoardState() => newGame();

  const BoardState._internal({
    this.enPassantTarget = '-',
    this.castlingRights = 'KQkq',
    this.squares = const [],
  });

  static BoardState newGame() {
    return BoardState._internal(squares: _initialSquares());
  }

  Piece? getPiece(Coordinate loc) =>
      (squares[loc.x][loc.y] is Piece) ? squares[loc.x][loc.y] as Piece : null;

  Coordinate findKingSquare(bool isWhite) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (squares[i][j] is King && (squares[i][j] as King).isWhite == isWhite)
          return Coordinate(i, j);
      }
    }
    throw Exception('The ${isWhite ? 'white' : 'black'} King went missing!');
  }

  BoardState showLegalMoves(List<Coordinate> legalMoves) {
    List<List<Square>> resultSquares = squares;
    for (Coordinate legalMove in legalMoves) {
      resultSquares[legalMove.x][legalMove.y] =
          squares[legalMove.x][legalMove.y].copyWith(isLegalTarget: true);
    }
    return copyWith(squares: resultSquares);
  }

  BoardState clearLegalMoves() => copyWith(
      squares: squares
          .map((ranks) => ranks
              .map((square) => square.copyWith(isLegalTarget: false))
              .toList())
          .toList());

  BoardState copyWith({
    String? enPassantTarget,
    String? castlingRights,
    List<List<Square>>? squares,
  }) {
    return BoardState._internal(
      enPassantTarget: enPassantTarget ?? this.enPassantTarget,
      castlingRights: castlingRights ?? this.castlingRights,
      squares: squares ?? this.squares,
    );
  }

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
      ];
}
