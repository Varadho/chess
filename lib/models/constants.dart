import 'board/coordinate.dart';

enum GameState { PLAYING, DRAW, WIN }

const List<String> FILES = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

const List<int> RANKS = [1, 2, 3, 4, 5, 6, 7, 8];

const Vector RIGHT = Vector(1, 0);
const Vector LEFT = Vector(-1, 0);
const Vector UP = Vector(0, 1);
const Vector DOWN = Vector(0, -1);

const List<Vector> DIAGONALS = [
  Vector(1, 1),
  Vector(-1, 1),
  Vector(-1, -1),
  Vector(1, -1),
];
const List<Vector> STRAIGHTS = [LEFT, RIGHT, UP, DOWN];

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
