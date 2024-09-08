// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/show_dialog.dart';
import 'package:todoapp/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();


  @override
  void initState(){
    // if this is first time ever opening this app...
    if (_myBox.get("TODOLIST") == null) {
      db.initialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // take user's input
  final _controller = TextEditingController();

  // task list ( NO NEED OF THIS AFTER INTEGRATING THE 'HIVE' DB... )
  // List db.ToDoList = [
  //   ['make app', false],
  //   ['do excercise', false],
  // ];

  // method to handle check-box
  void checkBoxChange(bool? value, int index){
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];
    });
    db.updateDatabase();
  }

  // method to create new task
  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask, 
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  // method to save new task
  void saveNewTask() {
    setState(() {
      db.ToDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }


  // method to delete task
  void deleteTask(int index) {
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'To Do',
          style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 60,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.ToDoList[index][0],
            taskCompleted: db.ToDoList[index][1], 
            onChanged: (value) => checkBoxChange(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      )
    );
  }
}