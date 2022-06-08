class Coordinate {
  final int x, y;

  Coordinate(this.x, this.y);

  Coordinate operator +(Vector v) => Coordinate(x + v.dx, y + v.dy);

  Vector distanceTo(Coordinate other) =>
      Vector(this.x - other.x, this.y - other.y);

  @override
  String toString() => 'Coordinate($x,$y)';
}

class Vector {
  final int dx, dy;

  Vector(this.dx, this.dy);

  Coordinate operator +(Coordinate c) => Coordinate(c.x + dx, c.y + dy);

  Vector operator |(Vector v) => Vector(v.dx + dx, v.dy + dy);
}
