import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../squares/piece.dart';
import 'coordinate.dart';

part 'move.g.dart';

@CopyWith()
class Move extends Equatable {
  final Coordinate start;
  final Coordinate target;

  const Move({
    required this.start,
    required this.target,
  });

  @override
  List<Object?> get props => [start, target];
}

class Capture extends Move {
  final Piece capturedPiece;

  Capture({
    required this.capturedPiece,
    required Coordinate start,
    required Coordinate target,
  }) : super(start: start, target: target);
}

@CopyWith()
class Turn extends Equatable {
  final Move whitesMove;
  final Move? blacksMove;

  Turn({required this.whitesMove, this.blacksMove});

  @override
  List<Object?> get props => [whitesMove, blacksMove];
}
