import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/bloc/states.dart';
import 'package:todo_app/core/cache_helper.dart';
import 'package:todo_app/core/themes/colors.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  List<Map> allTasks = [];
  List<Map> completedTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> favoriteTasks = [];

  void createDataBase() {
    openDatabase(
      'ToDoApp.db',
      version: 1,
      onCreate: (database, version) {
        database
            .execute(
          'CREATE TABLE TASKS (id INTEGER PRIMARY KEY , title TEXT , data TEXT , startTime TEXT , endTime TEXT,remind TEXT, isComplete TEXT , isFavorite TEXT,color TEXT)',
        )
            .then((value) {
          debugPrint('Table created');
        }).catchError((error) {
          debugPrint(error.toString());
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        getTodayTasks(database,DateFormat.yMMMd().format(selectedDay));
        debugPrint('DataBase Opened');
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  //----------------------------------------------------------------------------
  Future insertToDataBase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String color,
  }) {
    return database!.transaction((txn) async {
      await txn
          .rawInsert(
        'INSERT INTO TASKS(title,data,startTime,endTime,remind,isComplete,isFavorite,color) VALUES("$title","$date","$startTime","$endTime","$remind","false","false","$color")',
      )
          .then((value) {
        debugPrint('Insert Successfully');
        emit(InsertToDatabaseState());
        getDataFromDataBase(database);
      }).catchError((error) {
        debugPrint("ERROR");
        debugPrint(error.toString());
      });
    });
  }

  //----------------------------------------------------------------------------
  void getDataFromDataBase(database) {
    allTasks = [];
    completedTasks = [];
    unCompletedTasks = [];
    favoriteTasks = [];
    emit(GetFromDatabaseLoadingState());
    database.rawQuery('select * from Tasks').then((value) {
      value.forEach((element) {
        allTasks.add(element);
        if (element['isComplete'] == 'false') {
          unCompletedTasks.add(element);
        } else {
          completedTasks.add(element);
        }
        if (element['isFavorite'] == 'true') {
          favoriteTasks.add(element);
        }
      });
      // allTasks.sort((a,b){
      //   var aDate = a['data'];
      //   var bDate = b['data'] ;
      //   return aDate.compareTo(bDate);
      // });
      // allTasks.sort((a,b){
      //   if(a['data']==b['data']){
      //     var aDate = a['startTime'];
      //     var bDate = b['startTime'];
      //     return aDate.compareTo(bDate);
      //   }else {
      //     return a['startTime'];
      //   }
      // });
      //

      allTasks.sort((a, b) {
        int compare = a['data'].compareTo(b['data']);
        if (compare == 0) {
          var a1 = a['startTime'];
          var b1 = b['startTime'];
          return a1.compareTo(b1);
        } else {
          return compare;
        }
      });
      emit(GetFromDatabaseSuccessState());
    });
  }

  //----------------------------------------------------------------------------
  bool? isComplete;
  void changeIsComplete(bool val){
    isComplete = val;
  }

  void updateIsCompleteInDataBase({
    required String isComplete,
    required int id,
  }) {
    database!.rawUpdate(
      'UPDATE TASKS SET isComplete = ? WHERE id = ?',
      [isComplete, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(UpdateStatusInDataBaseSuccessState());
    });
  }

//------------------------------------------------------------------------------
  void updateIsFavoriteInDataBase({
    required String isFavorite,
    required int id,
  }) {
    database!.rawUpdate(
      'UPDATE TASKS SET isFavorite = ? WHERE id = ?',
      [isFavorite, id],
    ).then((value) {
      getDataFromDataBase(database);
      emit(UpdateIsFavoriteInDataBaseSuccessState());
    });
  }

  //----------------------------------------------------------------------------
  void deleteItemFromDataBase({
    required int id,
  })  {
    database!.rawDelete('DELETE FROM TASKS WHERE id = ?', [id]).then((value) {
      getDataFromDataBase(database);
      emit(DeleteItemFromDataBaseSuccessState());
    });
  }

  //----------------------------------------------------------------------------
  DateTime selectedDay = DateTime.now();

  List<Map> filteredTasksBasedOnDate = [];

  void changeSelectedDay(DateTime selected) {
    selectedDay = selected;
    emit(ChangeSelectedDaySuccessState());
  }

  void getTodayTasks(database, String selected) {
    filteredTasksBasedOnDate=[];
    debugPrint('Get Today Tasks');
    database.rawQuery(
        'SELECT * FROM TASKS WHERE data = ?', [selected]).then((value) {
          for(var item in value){
            filteredTasksBasedOnDate.add(item);
          }
          filteredTasksBasedOnDate.sort((a,b) {
            var aDate = a['startTime'];
            var bDate = b['startTime'] ;
            return aDate.compareTo(bDate);
          });
      emit(GetTodayTasksSuccessState());
    });
  }
  int colorIndex = 0;
  Color noteColor = myRed;

  void changeColorIndex(int index) {
    colorIndex = index;
    noteColor = Color(myColors[index]);
    emit(ChangeColorIndexState());
  }

  List<int> myColors = [
    0xffff5147,
    0xffff9d42,
    0xfff9c50b,
    0xff42a0ff,
    0xff25c06d,
    0xffa0906e,
    0xFF00897B,
  ];

  bool isDark=false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared ;
      emit(ChangeAppModeState());
    }else
    {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }

}
