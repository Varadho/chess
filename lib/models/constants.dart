import 'board/coordinate.dart';

const List<String> FILES = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

const List<int> RANKS = [1, 2, 3, 4, 5, 6, 7, 8];

const List<Vector> DIAGONALS = [
  Vector(1, 1),
  Vector(-1, 1),
  Vector(-1, -1),
  Vector(1, -1),
];
const List<Vector> STRAIGHTS = [
  Vector(1, 0),
  Vector(-1, 0),
  Vector(0, -1),
  Vector(0, 1),
];

const List<Vector> OMNI = [...DIAGONALS, ...STRAIGHTS];

const List<Vector> HORSEY = [
  Vector(2, 1),
  Vector(-2, 1),
  Vector(2, -1),
  Vector(-2, -1),
  Vector(1, 2),
  Vector(1, -2),
  Vector(-1, 2),
  Vector(-1, -2),
];
