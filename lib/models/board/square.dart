import 'package:my_own_chess/models/pieces/piece.dart';

import '../constants.dart';

class Square extends Comparable<Square> {
  final String file;
  final int rank;
  final Piece? piece;
  final bool isLegalTarget;

  String get name => '$file$rank';

  Square(this.file, this.rank, {this.isLegalTarget = false, this.piece});

  int get fileIndex => files.indexOf(file);

  @override
  int compareTo(Square other) {
    return other.rank - rank == 0
        ? fileIndex - other.fileIndex
        : other.rank - rank;
  }

  @override
  String toString() => '$name ${piece != null ? piece.runtimeType : ''}';
}
