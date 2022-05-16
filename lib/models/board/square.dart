import 'package:my_own_chess/models/pieces/piece.dart';

import '../constants.dart';

class Square extends Comparable<Square> {
  final String file;
  final int rank;
  final Piece? piece;
  final bool isLegalTarget;

  String get name => '$file$rank';

  Square(this.file, this.rank, {this.isLegalTarget = false, this.piece});

  int get fileIndex => FILES.indexOf(file);

  bool get isEmpty => piece == null;

  bool get isNotEmpty => !isEmpty;

  @override
  int compareTo(Square other) =>
      other.rank - rank == 0 ? fileIndex - other.fileIndex : other.rank - rank;

  @override
  String toString() =>
      '$name|${piece?.runtimeType ?? 'empty'}${isLegalTarget ? '|target' : ''}';

  Square copyWith({
    String? file,
    int? rank,
    bool? isLegalTarget,
    Piece? piece,
  }) {
    return Square(
      file ?? this.file,
      rank ?? this.rank,
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
      piece: piece ?? this.piece,
    );
  }
}
