const List<String> FILES = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
const List<int> RANKS = [1, 2, 3, 4, 5, 6, 7, 8];
const BOARD_WIDTH = 8;
const DIRECTION_UP = -BOARD_WIDTH;
const DIRECTION_TOP_RIGHT = -(BOARD_WIDTH + 1);
const DIRECTION_RIGHT = 1;
const DIRECTION_BOTTOM_RIGHT = -DIRECTION_TOP_RIGHT;
const DIRECTION_BOTTOM = BOARD_WIDTH;
const DIRECTION_BOTTOM_LEFT = BOARD_WIDTH - 1;
const DIRECTION_LEFT = -DIRECTION_RIGHT;
const DIRECTION_TOP_LEFT = -DIRECTION_BOTTOM_LEFT;

const DIRECTIONS = const [
  DIRECTION_UP,
  DIRECTION_TOP_RIGHT,
  DIRECTION_RIGHT,
  DIRECTION_BOTTOM_RIGHT,
  DIRECTION_BOTTOM,
  DIRECTION_BOTTOM_LEFT,
  DIRECTION_LEFT,
  DIRECTION_TOP_LEFT,
];

const KNIGHT_MOVES = const [
  BOARD_WIDTH * 2 + 1,
  BOARD_WIDTH * 2 - 1,
  -(BOARD_WIDTH * 2 + 1),
  -(BOARD_WIDTH * 2 - 1),
  BOARD_WIDTH + 2,
  BOARD_WIDTH - 2,
  -(BOARD_WIDTH + 2),
  -(BOARD_WIDTH - 2),
];
