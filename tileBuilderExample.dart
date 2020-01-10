import 'package:flutter/material.dart';

Widget _tileBuilder(BuildContext context, int gridIndex) {
  final Container wall = Container(Colors.green);
  final Container floor = Container(Colors.white);

  /// The index in the [GridView] of the current row.
  int rowIndex = gridIndex ~/ columns;

  /// The index in the [GridView] of the current column.
  int columnIndex = gridIndex % columns;

  /// The index in the [currentRow] of the maze of the current cell.
  int cellIndex = columnIndex ~/ 2;

  /// The position of the top left of the current tile.
  Position tilePosition = Position(columnIndex * tileSize, rowIndex * tileSize);

  if (rowIndex % 2 == 0) {
    /// Every other row is a wall row - current row is a wall row!
    if (rowIndex == 0) {
      /// This is the first row! All walls!
      return wall;
    }

    /// Otherwise, return the corresponding wall tile.
    /// Also add to [walls] if the nextWallRowTile is a wall.
    Widget nextWallRowTile = wallRow[columnIndex];
    if (nextWallRowTile == wall) _addToWalls(wall, tilePosition);
    return nextWallRowTile;
  }

  /// If not a wall row and at the start/end of the row;
  if (columnIndex == 0) {
    /// Fetch the new row in it's raw form.
    currentRow =
        _mazeBuilder.getNextRow(previousRow, isFirst: gridIndex < columns);

    /// Reset the [wallRow].
    wallRow = [];

    /// The first tile will always be a wall!
    _addToWalls(wall, tilePosition);
    wallRow.add(wall);
    return wall;
  } else if (columnIndex == columns - 1) {
    /// On the last tile- update [previousRow].
    previousRow = currentRow;

    /// The last tile will always be a wall!
    _addToWalls(wall, tilePosition);
    wallRow.add(wall);
    return wall;
  }

  if (columnIndex % 2 != 0) {
    Cell currentCell = currentRow[cellIndex];

    /// Update the [nextTile].
    nextTile = currentCell.hasRightWall ? wall : floor;

    /// Update the [wallRow].
    wallRow.add(currentCell.hasBottomWall ? wall : floor);

    return floor;
  } else {
    if (nextTile == wall) _addToWalls(nextTile, tilePosition);
    wallRow.add(nextTile);

    return nextTile;
  }
}

void _addToWalls(Widget wall, Position tilePosition) {
  /// Adds a wall to the list of barriers: NOT the same as
  /// [wallRow], which contains all of the tiles in the next row.
  Rect wallRect =
      Rect.fromLTWH(tilePosition.x, tilePosition.y, tileSize, tileSize);
  walls.add(wallRect);
}
