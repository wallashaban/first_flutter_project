// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_course/layout/todoapp/cubit/states.dart';

import '../../../modules/todo_app/archived/archived.dart';
import '../../../modules/todo_app/done_tasks/done_tasks.dart';
import '../../../modules/todo_app/tasks/tasks.dart';

class TodoAppCubit extends Cubit<TodoAppStates> {
  TodoAppCubit() : super(TodoAppInitialState());

  static TodoAppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const Tasks(),
    const DoneTasks(),
    const ArchivedTasks(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archvied Tasks',
  ];

  void changeBottomNavbar(index) {
    currentIndex = index;
    emit(TodoAppChangeBottomNavbarState());
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({required bool isShow, required icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(TodoAppChangeBottomsheet());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() async {
    emit(TodoAppCreateDatabaseLoadingState());
    database = await openDatabase('todo.db', version: 1,
        onCreate: ((database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
        emit(TodoAppCreateDatabaseSuccessState());
      }).catchError((error) {
        print('Error when creating table ${error.toString()}');
        emit(TodoAppCreateDatabaseErrorState());
      });
    }), onOpen: (database) {
      print('database opened');

      getDataFromDatabase(database);
    });
  }

  Future<String> getName() async {
    return 'hello';
  }

  Future insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    emit(TodoAInsertIntoDatabaseLoadingState());
    return await database!.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")')
          .then((value) {
        emit(TodoAppInsertIntotabaseSuccessState());
        getDataFromDatabase(database);
        print('$value Rows inserted');
      }).catchError((error) {
        print('Error when inserting row ${error.toString()}');
        emit(TodoAInsertIntoDatabaseErrorState());
      });
      return getName();
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database!.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New') newTasks.add(element);
        if (element['status'] == 'done') doneTasks.add(element);
        if (element['status'] == 'archived') archivedTasks.add(element);
      });
      print(newTasks);
      emit(TodoAppGetDataFromDatabaseSuccessState());
    });
  }

  void updateDatabase({
    required String status,
    required int id,
  }) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      getDataFromDatabase(database);
      emit(TodoAppUpdateDatabaseSuccessState());
    });
  }

  void deleteDatabase({
    required int id,
  }) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(TodoAppDeleteDatabaseSuccessState());
    });
  }
}
