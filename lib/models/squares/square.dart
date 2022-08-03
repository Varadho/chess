part of 'piece.dart';

/// The super class for all of our squares. All pieces extend off of this,
class Square {
  final bool isLegalTarget;

  const Square({this.isLegalTarget = false});

  @override
  String toString() => ' ';

  Square copyWith({bool? isLegalTarget}) =>
      Square(isLegalTarget: isLegalTarget ?? this.isLegalTarget);
}
