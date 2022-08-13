import 'package:flutter/material.dart';
import 'package:udemy_course/shared/components/components.dart';

// ignore: must_be_immutable
class BmiRes extends StatelessWidget {
  final bool gender;
  final int age;
  final double result;
  // ignore: use_key_in_widget_constructors
  const BmiRes({required this.age, required this.gender, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff302c2c),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff302c2c),
        title: titleText(text: '            BMI RESULT', color: Colors.white),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titleText(
              text: 'GENDER : ${gender ? 'MALE' : 'FEMALE'}',
              color: Colors.white),
          titleText(text: 'RESULT : ${result.round()}', color: Colors.white),
          titleText(text: 'AGE : $age', color: Colors.white),
        ],
      )),
    );
  }
}
