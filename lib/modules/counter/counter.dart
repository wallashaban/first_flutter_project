import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titleText(text: 'Counter', color: Colors.white)),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    counter--;
                  });
                },
                child: titleText(text: 'Minus', color: Colors.blue)),
            titleText(
              text: '$counter',
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    counter++;
                  });
                },
                child: titleText(text: 'Plus', color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
