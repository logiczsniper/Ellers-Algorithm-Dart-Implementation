### Eller's Algorithm Implentation in Dart
A maze generation algorithm which creates a maze with at least one solution and can be scaled to any size.

##### Source
I took the explanation of the algorithm [here](http://www.neocomputer.org/projects/eller.html) and wrote the equivalent in Dart.

##### Example
The following is some sample output for a 10 x 20 maze: <br>
```
|   | |    _ _    | |
| |_ _| |  _ _| |   |
| |   | | |_  | | |_|
|  _|_   _  |    _ _|
|_  |  _     _  | | |
|_  |  _|_| |_  |   |
| | | | | | | | |_| |
|_ _ _ _     _| | | |
|   |  _    |_  | | |
|_| |_| |_| |       |
| |  _     _|_|_| |_|
| |  _|_| |_  |     |
|_   _ _| | | | |_|_|
| |_    | |_ _ _ _  |
| |    _|  _        |
| |_|  _   _      | |
| | |  _|_| |_|_|_| |
| |_       _| |    _|
| |_  | |_  |_    | |
| |   | | |_ _ _ _  |
```

##### Flutter Usage
You can generate infinitely long mazes by simply generating the next row as needed. This can be used with Flutter's ListView.builder
method where the length is not specified. See the tileBuilder method example script.