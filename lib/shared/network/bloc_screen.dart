import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/bloc_model/bloc_model.dart';
import 'package:todo_app/modules/archived_taskes/archived_taskes.dart';
import 'package:todo_app/modules/done_taskes/done_taskes.dart';
import 'package:todo_app/modules/new_taskes/new-taskes.dart';


class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Database database;

  List<Map> newTask = [];
  List<Map> doneTask = [];
  List<Map> archiveTask = [];
  List<String> title = ['NewTask', 'DoneTask', ' ArchivedTask'];
  List<Widget> screen = [NewTask(), DoneTask(), ArchivedTask()];
  bool isBottomSheetShown = false;
  IconData fIconData = Icons.edit;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppOnChangeNavBottom());
  }

  void createDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      print('data  created');
      await database.execute(
          'CREATE TABLE task ( id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT, status TEXT)');
      print('table created');
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('is opened');
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  void insertDataBase({
    String title,
    String date,
    String time,
    String status,

  }) async {
    await database.transaction((txn) {
      txn.rawInsert(
              'INSERT INTO task (title, time, date ,status) VALUES("$title", "$time", "$date","New")')
          .then((value) {
        print('$value send successfully');
        getDataFromDatabase(database);
        emit(AppInsertDataBaseState());
      }).catchError((error) {
        print('some thing ${error.toString()}');
      });
      return null;

    });

  }

  void getDataFromDatabase(database) {
    newTask = [];
    doneTask = [];
    archiveTask = [];
    emit(AppGetDataBaseState());
    database.rawQuery('SELECT * FROM task').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New')
          newTask.add(element);
        else if (element['status'] == 'DONE')
          doneTask.add(element);
        else
          archiveTask.add(element);
      });

      emit(AppGetDataBaseState());
    });
  }

  void changeBottomSheetState(
      {
        @required IconData fIcon,
        @required bool isShow,

      }) {
    isBottomSheetShown = isShow;
    fIconData = fIcon;
    emit(AppShowBottomSheetState());
  }

  void updateDateBase({
    @required String status,
    @required int id,
  }) async
  {


    database.rawUpdate('UPDATE task SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBaseState());
    });
  }

  void deleteDateBase({
    @required int id,
  }) async {
    database.rawDelete('DELETE FROM task WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBaseState());
    });
  }


}
