import 'package:flutter/material.dart';
import 'package:sudoku/components/banner.dart';
import 'package:sudoku/generation.dart';
import 'board.dart';

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
  List<List<int>> answer =
  generateAnswer(List.generate(9, (_) => List<int>.filled(9, 0)));
  late List<List<int>> board; //set as late because its being set in initState
  int kValue = 20;
  
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
          BannerHead(kValue: kValue,),
          Board(board: board, answer: answer),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        answer = generateAnswer(List.generate(9, (_) => List<int>.filled(9, 0)));
        List<List<int>> newBoard = removeKDigits(answer, kValue);
        setState(() {
          board = newBoard;
        });
      }),
    );
  }

  void _printBoard(List<List<int>> board) {
    for (List<int> rows in board) {
      print("$rows");
    }
  }
}