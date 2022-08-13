// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:udemy_course/layout/todoapp/cubit/cubit.dart';
import 'package:udemy_course/layout/todoapp/cubit/states.dart';
import 'package:udemy_course/shared/components/components.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Database? database;

  var taskController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoAppCubit, TodoAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TodoAppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: titleText(
                text: cubit.titles[cubit.currentIndex], color: Colors.white),
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (!cubit.isBottomSheetShown) {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      elevation: 20.0,
                      (context) => Form(
                        key: formKey,
                        child: Container(
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormFeild(
                                    controller: taskController,
                                    text: 'Task title',
                                    prefixIcon: Icons.title_sharp,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Task title must not be empty';
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormFeild(
                                    controller: timeController,
                                    text: 'Task time',
                                    prefixIcon: Icons.watch_later_sharp,
                                    type: TextInputType.datetime,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Task time must not be empty';
                                      }
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context);
                                      });
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                defaultFormFeild(
                                    controller: dateController,
                                    text: 'Task date',
                                    prefixIcon: Icons.date_range_sharp,
                                    type: TextInputType.datetime,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Task date must not be empty';
                                      }
                                    },
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate:
                                            DateTime.parse('2023-02-02'),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheet(icon: Icons.edit, isShow: false);
                  /* setState(() {
                      isBottomSheetShown = false;
                      fabIcon = Icons.edit;
                    }); */
                });
                cubit.changeBottomSheet(icon: Icons.add, isShow: true);
                /*  setState(() {
                    isBottomSheetShown = true;
                    fabIcon = Icons.add;
                  }); */
              } else {
                if (formKey.currentState!.validate()) {
                  cubit
                      .insertIntoDatabase(
                    title: taskController.text,
                    date: dateController.text,
                    time: timeController.text,
                  )
                      .then((value) {
                    Navigator.pop(context);
                    cubit.changeBottomSheet(icon: Icons.edit, isShow: false);
                    taskController.text = '';
                    dateController.text = '';
                    timeController.text = '';
                    /* setState(() {
                        isBottomSheetShown = false;
                        fabIcon = Icons.edit;
                      }); */
                  });
                }
              }
            },
            child: Icon(cubit.fabIcon),
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavbar(index);
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline_sharp),
                    label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ]),
        );
      },
    );
  }

  /*  void createDatabase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: ((database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when creating table ${error.toString()}');
      });
    }), onOpen: (database) {
      print('database opened');

      getDataFromDatabase(database).then((value) {
        tasks = value;

        print(tasks.length);
      });
    });
  }
 */

  /* Future insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    return await database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")')
          .then((value) {
        print('$value Rows inserted');
      }).catchError((error) {
        print('Error when inserting row ${error.toString()}');
      });
      return getName();
    });
  } */

  /*  Future<List<Map>> getDataFromDatabase(database) {
    return database!.rawQuery('SELECT * FROM tasks');
  }
 */
}
