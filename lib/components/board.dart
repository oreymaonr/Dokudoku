import 'package:flutter/material.dart';
import 'package:sudoku/generation.dart';
import 'choice.dart';
import 'singlecell.dart';

class Board extends StatefulWidget {
  const Board(
      {super.key,
        required this.board,
        required this.answer});

  final List<List<int>> board;
  final List<List<int>> answer;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final List<int> rows = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  final List<int> cols = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  int tappedRow = -1;
  int tappedCol = -1;
  late Color blankSpaceColor;
  List<int> sols=[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [        SizedBox(
        height: 400,
        width: double.infinity,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 3,
          children: <Widget>[
            for (var row in rows)
              GridView.count(
                primary: false,
                padding: const EdgeInsets.all(5),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                children: <Widget>[
                  for (var col in cols)
                    if (tappedCol == col && tappedRow == row)
                    //second click
                      GestureDetector(
                        onTap: () {
                          //TODO: Change Color
                          //_changeColor(col, row);
                          print(
                              "second click: $tappedCol,$tappedRow,$col,$row");
                          //TODO: select a value form choice
                          //TODO: set board value change
                        },
                        child: SingleCell(
                          val: "",
                          color: blankSpaceColor,
                        ),
                      )
                    else if (widget.board[row][col] == 0)
                    //first click
                      GestureDetector(
                        onTap: () {
                          print(
                              "first click :$tappedCol,$tappedRow,$col,$row");
                          _changeColor(col, row);
                          _genSolsList(widget.board, row, col);
                          // print(widget.sols);
                        },
                        child: const SingleCell(
                          val: "",
                          color: Colors.black,
                        ),
                      )
                    else
                      SingleCell(
                        val: widget.board[row][col].toString(),
                        color: Colors.teal[100] as Color,
                      )
                ],
              ),
          ],
        ),
      ),
        Choice(choices: sols),

      ],
    );
  }

  void _changeColor(int col, int row) {
    setState(() {
      blankSpaceColor = const Color.fromARGB(239, 237, 234, 13);
      tappedCol = col;
      tappedRow = row;
      // widget.answer[row][col] = 10;
    });
    print("answer: ${widget.answer[row][col]}");
  }

  void _genSolsList(board, row, col) {
    List<int> s = [];
    for (var i = 1; i < 10; i++) {
      // print("$i:${checkIfSafe(board, row, col, i)}");
      if (checkIfSafe(board, row, col, i)) {
        setState(() {
          s.add(i);
        });
      }
    }
    setState(() {
      sols = s;
    });
  }
}
