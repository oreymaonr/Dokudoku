import 'package:flutter/material.dart';

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
