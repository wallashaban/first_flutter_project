// ignore_for_file: sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:udemy_course/modules/bmi_res/bmi_res.dart';
import 'package:udemy_course/shared/components/components.dart';

// ignore: camel_case_types
class Bmi_Calculator extends StatefulWidget {
  const Bmi_Calculator({Key? key}) : super(key: key);

  @override
  State<Bmi_Calculator> createState() => _Bmi_CalculatorState();
}

// ignore: camel_case_types
class _Bmi_CalculatorState extends State<Bmi_Calculator> {
  bool isMale = true;
  var height = 120.0;
  var age = 21;
  var weight = 70;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff302c2c),
      appBar: AppBar(
        elevation: 0.0,
        title: titleText(
            text: '                 BMI CALCULATOR',
            color: Colors.white,
            size: 20),
        backgroundColor: const Color(0xff302c2c),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale ? const Color(0xff363333) : Colors.grey,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.female,
                              color: Colors.white,
                              size: 140,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            titleText(
                                text: 'FEMALE', color: Colors.white, size: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:
                              !isMale ? const Color(0xff363333) : Colors.grey,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.male,
                              color: Colors.white,
                              size: 140,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            titleText(
                                text: 'MALE', color: Colors.white, size: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xff363333),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleText(
                        text: 'HEIGHT',
                        color: Colors.grey,
                        fontWeight: FontWeight.w100),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        titleText(
                            text: '${height.round()}',
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                        titleText(
                            text: 'cm',
                            color: Colors.grey,
                            fontWeight: FontWeight.w100),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Slider(
                      value: height,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      },
                      min: 80,
                      max: 220,
                      activeColor: Colors.grey[200],
                      inactiveColor: Colors.grey,
                      thumbColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff363333),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          titleText(
                              text: 'WEIGHT',
                              color: Colors.grey,
                              fontWeight: FontWeight.w100),
                          const SizedBox(
                            height: 10,
                          ),
                          titleText(text: '$weight', color: Colors.white),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 35,
                                  child: FloatingActionButton(
                                    heroTag: 'w--',
                                    onPressed: () {
                                      setState(() {
                                        weight--;
                                      });
                                    },
                                    backgroundColor: Colors.grey,
                                    child: const Icon(
                                      Icons.remove,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 35,
                                  child: FloatingActionButton(
                                    heroTag: 'w++',
                                    onPressed: () {
                                      setState(() {
                                        weight++;
                                      });
                                    },
                                    backgroundColor: Colors.grey,
                                    child: const Icon(
                                      Icons.add,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff363333),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          titleText(
                              text: 'AGE',
                              color: Colors.grey,
                              fontWeight: FontWeight.w100),
                          const SizedBox(
                            height: 10,
                          ),
                          titleText(text: '$age', color: Colors.white),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 35,
                                  child: FloatingActionButton(
                                    heroTag: 'a--',
                                    onPressed: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                    backgroundColor: Colors.grey,
                                    child: const Icon(
                                      Icons.remove,
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: 35,
                                  child: FloatingActionButton(
                                    heroTag: 'a++',
                                    onPressed: () {
                                      setState(() {
                                        age++;
                                      });
                                    },
                                    backgroundColor: Colors.grey,
                                    child: const Icon(
                                      Icons.add,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                color: const Color(0xffe03e36),
                child: MaterialButton(
                  onPressed: () {
                    var res = weight / pow(height / 100, 2);
                    navigateTo(
                        context: context,
                        widget: BmiRes(age: age, gender: isMale, result: res));
                  },
                  child: titleText(text: 'CALCULATE', color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
