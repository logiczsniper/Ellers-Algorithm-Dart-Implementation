/// Implementation of Eller's in Dart, as described in English from http://www.neocomputer.org/projects/eller.html
///
/// This algorithm generates a maze with atleast one guarenteed path through it and can be as long as you
/// want it to be, simply generate the next row using the previous row.
///
/// Logan Czernel
/// lczernel@gmail.com

import 'dart:math';
import 'cell.dart';

class MazeBuilder {
  final int columns;

  MazeBuilder(this.columns);

  List<Cell> getNextRow(List<Cell> startingRow, {bool isFirst = false}) {
    Random random = Random();

    List<Cell> newRow = startingRow;

    if (!isFirst) {
      /// If it is not the first row, it must be prepared before anything!
      newRow = _prepareNextRow(newRow);
    }

    newRow = _joinCells(newRow);

    /// Create right walls
    for (int i = 0; i < columns - 1; i++) {
      Cell current = newRow[i];
      Cell next = newRow[i + 1];

      if (random.nextBool() || current.setNumber == next.setNumber) {
        /// Add a wall to current cell.
        current.hasRightWall = true;
      } else {
        /// Union the sets of the current and next.
        next.setNumber = current.setNumber;
      }
    }

    /// Create bottom walls
    for (int i = 0; i < columns; i++) {
      Cell current = newRow[i];
      int setCount = _getCellSetCount(current.setNumber, newRow);
      int setWithoutBottomCount =
          _getCellSetCountWithoutBottomWall(current.setNumber, newRow);

      if (setCount == 1 || setWithoutBottomCount == 1) {
        /// Do not make a wall!
        continue;
      } else if (random.nextBool()) {
        /// Assuming the first conditional wasnt reached, now its down to luck!
        /// Create a bottom wall on the current cell!
        current.hasBottomWall = true;
      }
    }
    return newRow;
  }

  static List<Cell> _joinCells(List<Cell> preparedRow) {
    /// Takes prepared row (with null set values) and
    /// outputs a filled row of cells where each cell which
    /// previously had a null set number now has a unique set number.

    /// Get a list of the available set numbers which are unique and sorted.
    int highestCurrentSetNumber = 0;
    for (Cell cell in preparedRow) {
      if (cell.setNumber == null) {
        continue;
      }
      if (cell.setNumber > highestCurrentSetNumber) {
        highestCurrentSetNumber = cell.setNumber;
      }
    }
    List<int> availableSetNumbers =
        List<int>.generate(highestCurrentSetNumber, (i) => i);
    for (Cell cell in preparedRow) {
      if (cell.setNumber == null) {
        continue;
      }
      if (availableSetNumbers.contains(cell.setNumber)) {
        /// This set number has been taken- its not actually available!
        availableSetNumbers.remove(cell.setNumber);
      }
    }

    /// Assign these values to cells with a null [setNumber].
    for (Cell cell in preparedRow) {
      if (cell.setNumber == null && availableSetNumbers.length > 0) {
        int newSetNumber = availableSetNumbers.removeAt(0);
        cell.setNumber = newSetNumber;
      } else if (cell.setNumber == null) {
        /// Ran out of available set numbers! Use the highest current set number + 1.
        cell.setNumber = highestCurrentSetNumber + 1;
        highestCurrentSetNumber += 1;
      }
    }

    return preparedRow;
  }

  static List<Cell> _prepareNextRow(List<Cell> currentRow) {
    for (Cell cell in currentRow) {
      /// Remove all right walls.
      cell.hasRightWall = false;

      /// If a cell has a bottom wall, remove it from its set.
      if (cell.hasBottomWall) {
        cell.setNumber = null;
      }

      /// Remove all bottom walls.
      cell.hasBottomWall = false;
    }

    /// This row is now ready to loop back to the joining phase!
    return currentRow;
  }

  static int _getCellSetCountWithoutBottomWall(int setNumber, List<Cell> row) {
    /// Get the number of cells with [setNumber] in the
    /// [row] that do not have a bottom wall already.

    int count = 0;

    for (Cell cell in row) {
      if (cell.setNumber == setNumber && !cell.hasBottomWall) {
        count += 1;
      }
    }

    return count;
  }

  static int _getCellSetCount(int setNumber, List<Cell> row) {
    /// Get the number of cells with [setNumber] in the
    /// [row].

    int count = 0;

    for (Cell cell in row) {
      if (cell.setNumber == setNumber) {
        count += 1;
      }
    }

    return count;
  }
}
