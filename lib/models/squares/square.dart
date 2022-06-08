part of 'piece.dart';

class Square {
  final bool isLegalTarget;

  const Square({this.isLegalTarget = false});

  Square copyWith({bool? isLegalTarget}) =>
      Square(isLegalTarget: isLegalTarget ?? this.isLegalTarget);
}
