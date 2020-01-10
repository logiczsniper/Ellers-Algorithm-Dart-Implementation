/// Printing methods for displaying maze elements.

import 'cell.dart';

class MazePrinter {
  static void printRow(List<Cell> row) {
    String output = "|";
    for (Cell cell in row) {
      if (cell == row.last) {
        if (cell.hasBottomWall)
          output += "_";
        else
          output += " ";
        continue;
      }
      output += cell.toString();
    }
    print("$output|");
  }
}
