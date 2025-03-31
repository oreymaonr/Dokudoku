import 'package:flutter/material.dart';

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
