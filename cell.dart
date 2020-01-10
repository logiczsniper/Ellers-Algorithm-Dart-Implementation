/// A [Cell] represents a single unit of the maze.
///
/// The [setNumber] is crucial for the cell merging phase of the algorithm.
/// The algorithm manipulates the two boolean values [hasBottomWall] and [hasRightWall].

class Cell {
  int setNumber;
  bool hasBottomWall;
  bool hasRightWall;

  Cell(this.setNumber, this.hasBottomWall, this.hasRightWall);
  Cell.first(int setNumber) : this(setNumber, false, false);

  bool get hasBoth => hasBottomWall && hasRightWall;

  String toString() {
    String after = hasRightWall ? "|" : " ";
    String under = hasBottomWall ? "_" : " ";
    return "$under$after";
  }
}
