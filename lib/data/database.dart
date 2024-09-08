import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  // todo list
  List ToDoList = [];
  
  // reference our box
  final _myBox = Hive.box('mybox');

  // if this is first time ever opening this app
  void initialData() {
      ToDoList = [
        ['Make app', false],
        ['Do excercise', false],
    ];
  }

  // if data exists already
  void loadData() {
    ToDoList = _myBox.get('TODOLIST');
  }

  // update the database
  void updateDatabase() {
    _myBox.put('TODOLIST', ToDoList);
  }
}