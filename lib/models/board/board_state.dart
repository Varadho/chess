import 'package:my_own_chess/models/board/square.dart';
import 'package:my_own_chess/models/pieces/piece.dart';

import '../constants.dart';

class BoardState {
  final List<Square> squares;
  final String enPassantTarget;
  final String castlingRights;

  factory BoardState() => newGame();

  BoardState._internal({
    this.enPassantTarget = '-',
    this.castlingRights = 'KQkq',
    this.squares = const [],
  });

  static BoardState newGame() {
    return BoardState._internal(squares: _initialSquares());
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
        for (String file in files) ...[
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
      for (String file in files)
        for (int rank in ranks.getRange(2, 6).toList()) Square(file, rank)
    ]..sort();
  }
}
