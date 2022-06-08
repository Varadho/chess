class Square {
  final bool isLegalTarget;

  const Square({this.isLegalTarget = false});

  Square copyWith({
    bool? isLegalTarget,
  }) {
    return Square(
      isLegalTarget: isLegalTarget ?? this.isLegalTarget,
    );
  }
}
