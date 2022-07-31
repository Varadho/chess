part of 'piece.dart';

class Square {
  final bool isLegalTarget;

  const Square({this.isLegalTarget = false});

  @override
  String toString() => ' ';

  Square copyWith({bool? isLegalTarget}) =>
      Square(isLegalTarget: isLegalTarget ?? this.isLegalTarget);

  @override
  List<Object?> get props => [isLegalTarget];
}
