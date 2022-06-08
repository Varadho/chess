import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  final int x;
  final int y;

  const Coordinate(this.x, this.y);

  Coordinate operator +(Vector v) => Coordinate(x + v.dx, y + v.dy);

  Vector distanceTo(Coordinate other) =>
      Vector(this.x - other.x, this.y - other.y);

  bool get isOnTheBoard => x < 8 && x >= 0 && y < 8 && y >= 0;

  @override
  String toString() => 'Coordinate(x:$x, y:$y)';

  @override
  List<Object?> get props => [x, y];
}

class Vector extends Equatable {
  final int dx;
  final int dy;

  const Vector(this.dx, this.dy);

  Vector operator +(Vector v) => Vector(v.dx + dx, v.dy + dy);

  Vector operator *(int i) => Vector(dx * i, dy * i);

  Vector operator /(int i) => Vector((dx / i).round(), (dy / i).round());

  @override
  List<Object?> get props => [dx, dy];
}
