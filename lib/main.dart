import 'package:flutter/material.dart';
import 'package:sudoku/generation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dokudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sudoku 9*9'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List<int>> answer =
      generateAnswer(List.generate(9, (_) => List<int>.filled(9, 0)));
  late List<List<int>> board;

  @override
  void initState() {
    board = removeKDigits(answer, 50);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.album),
            title: Text('The Enchanted Nightingale'),
            subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
          ),
          Board(board: board, answer: answer),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _printBoard(board);        
      }),
    );
  }

  void _printBoard(List<List<int>> board) {
    for (List<int> rows in board) {
      print("$rows");
    }
  }
}

class Board extends StatefulWidget {
  Board(
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

class Choice extends StatelessWidget {
  const Choice({super.key, required this.choices});
  final List<int> choices;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var choice in choices)
             FilledButton.tonal(               
              onPressed: (){},               
              child: Text(
                choice.toString()
              )
            )
        ],
      )
    );
  }
}

class SingleCell extends StatefulWidget {
  const SingleCell({super.key, required this.val, required this.color});
  final String val;
  final Color color;

  @override
  State<SingleCell> createState() => _SingleCellState();
}

class _SingleCellState extends State<SingleCell> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          // padding: const EdgeInsets.all(1),
          // color: Colors.teal[100],
          color: widget.color,
          child: Center(child: Text(widget.val))),
    );
  }
}
