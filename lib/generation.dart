import 'dart:math';

List<List<int>> generateAnswer(List<List<int>> grid) {
  fillDiagonal(grid);
  fillRemaining(grid, 0, 3);
  // removeKDigits(grid, 20);
  //printGrid(grid);
  return grid;
}

void fillDiagonal(List<List<int>> grid) {
  for (int i = 0; i < 9; i += 3) {
    fillBox(grid, i, i);
  }
}

void fillBox(List<List<int>> grid, int row, int col) {
  int num;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      do {
        num = Random().nextInt(9) + 1;
      } while (!unUsedInBox(grid, row, col, num));
      grid[row + i][col + j] = num;
    }
  }
}

bool unUsedInBox(List<List<int>> grid, int rowStart, int colStart, int num) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (grid[rowStart + i][colStart + j] == num) {
        return false;
      }
    }
  }
  return true;
}

bool unUsedInRow(List<List<int>> grid, int i, int num) {
  for (int j = 0; j < 9; j++) {
    if (grid[i][j] == num) {
      return false;
    }
  }
  return true;
}

bool unUsedInCol(List<List<int>> grid, int j, int num) {
  for (int i = 0; i < 9; i++) {
    if (grid[i][j] == num) {
      return false;
    }
  }
  return true;
}

bool checkIfSafe(List<List<int>> grid, int i, int j, int num) {
  return (unUsedInRow(grid, i, num) &&
      unUsedInCol(grid, j, num) &&
      unUsedInBox(grid, i - i % 3, j - j % 3, num));
}

bool fillRemaining(List<List<int>> grid, int i, int j) {
  if (j >= 9 && i < 8) {
    i = i + 1;
    j = 0;
  }
  if (i >= 9 && j >= 9) {
    return true;
  }
  if (i < 3) {
    if (j < 3) {
      j = 3;
    }
  } else if (i < 6) {
    if (j == (i / 3).floor() * 3) {
      j = j + 3;
    }
  } else {
    if (j == 6) {
      i = i + 1;
      j = 0;
      if (i >= 9) {
        return true;
      }
    }
  }
  for (int num = 1; num <= 9; num++) {
    if (checkIfSafe(grid, i, j, num)) {
      grid[i][j] = num;
      if (fillRemaining(grid, i, j + 1)) {
        return true;
      }
      grid[i][j] = 0;
    }
  }
  return false;
}

List<List<int>> removeKDigits(List<List<int>> ans, int k) {
  Random rand = Random();
  List<List<int>> grid =
      generateAnswer(List.generate(9, (_) => List<int>.filled(9, 0)));
  for (var i = 0; i < 9; i++) {
    for (var j = 0; j < 9; j++) {
      grid[i][j] = ans[i][j];
    }
  }
  while (k > 0) {
    int cellId = rand.nextInt(81);
    int i = cellId ~/ 9;
    int j = cellId % 9;
    if (grid[i][j] != 0) {
      grid[i][j] = 0;
      k--;
    }
  }
  return grid;
}

void printGrid(List<List<int>> grid) {
  for (List<int> row in grid) {
    print("$row");
  }
}
