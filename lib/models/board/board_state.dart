import 'package:my_own_chess/models/board/square.dart';
import 'package:my_own_chess/models/pieces/piece.dart';

import '../constants.dart';

class BoardState {
  /// A List of 64 squares which represents the chess board
  final List<Square> squares;

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

  Piece? getPiece(String file, int rank) => squares
      .firstWhere(
        (square) => square.file == file && square.rank == rank,
        orElse: () => Square(file, rank),
      )
      .piece;

  BoardState showLegalMoves(List<Square> legalMoves) {
    return copyWith(
      squares: squares.map((mappedSquare) {
        if (legalMoves.any((legalMove) =>
            legalMove.rank == mappedSquare.rank &&
            legalMove.file == mappedSquare.file)) {
          return mappedSquare.copyWith(
            isLegalTarget: true,
          );
        }
        return mappedSquare;
      }).toList()
        ..sort(),
    );
  }

  BoardState clearLegalMoves() {
    return copyWith(
      squares: squares
          .map((square) => square.copyWith(isLegalTarget: false))
          .toList()
            ..sort(),
    );
  }

  BoardState copyWith({
    String? enPassantTarget,
    String? castlingRights,
    List<Square>? squares,
  }) {
    return BoardState._internal(
      enPassantTarget: enPassantTarget ?? this.enPassantTarget,
      castlingRights: castlingRights ?? this.castlingRights,
      squares: squares ?? this.squares,
    );
  }

  static List<Square> _initialSquares() {
    List<Square> _addKnights() => [
          Square('b', 1, piece: Knight()),
          Square('g', 1, piece: Knight()),
          Square('b', 8, piece: Knight(isWhite: false)),
          Square('g', 8, piece: Knight(isWhite: false)),
        ];

    List<Square> _addBishops() => [
          Square('c', 1, piece: Bishop()),
          Square('f', 1, piece: Bishop()),
          Square('c', 8, piece: Bishop(isWhite: false)),
          Square('f', 8, piece: Bishop(isWhite: false)),
        ];

    List<Square> _addRooks() => [
          Square('a', 1, piece: Rook()),
          Square('h', 1, piece: Rook()),
          Square('a', 8, piece: Rook(isWhite: false)),
          Square('h', 8, piece: Rook(isWhite: false)),
        ];

    List<Square> _addKings() => [
          Square('e', 1, piece: King()),
          Square('e', 8, piece: King(isWhite: false)),
        ];

    List<Square> _addQueens() => [
          Square('d', 1, piece: Queen()),
          Square('d', 8, piece: Queen(isWhite: false)),
        ];

    List<Square> _addPawns() {
      return [
        for (String file in FILES) ...[
          Square(file, 2, piece: Pawn()),
          Square(file, 7, piece: Pawn(isWhite: false))
        ]
      ];
    }

    return <Square>[
      ..._addPawns(),
      ..._addRooks(),
      ..._addKnights(),
      ..._addBishops(),
      ..._addQueens(),
      ..._addKings(),
      for (String file in FILES)
        for (int rank in RANKS.getRange(2, 6).toList()) Square(file, rank)
    ]..sort();
  }
}
