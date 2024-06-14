bool isSquareWhite(int index) {
  int x = index ~/ 8;
  int y = index % 8;
  bool isSquareWhite = (x + y) % 2 == 0;
  return isSquareWhite;
}

bool isInBoard(int row, int col) {
  return row >= 0 && row < 8 && col >= 0 && col < 8;
}