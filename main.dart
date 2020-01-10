import 'cell.dart';
import 'maze.dart';
import 'printer.dart';

/// Uses the [MazeBuilder] and [MazePrinter] to create and display a maze.
///
/// Logan Czernel
/// lczernel@gmail.com

void main() {
  final int columnCount = 10;
  final int rowCount = 20;
  final List<Cell> firstRow = List<Cell>.generate(
      columnCount, (int setNumber) => Cell.first(setNumber));
  final MazeBuilder mazeBuilder = MazeBuilder(columnCount);

  List<Cell> currentRow = firstRow;

  for (int i = 0; i < rowCount; i++) {
    currentRow = mazeBuilder.getNextRow(currentRow);
    MazePrinter.printRow(currentRow);
  }
}
