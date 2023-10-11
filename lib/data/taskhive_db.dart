import 'package:hive/hive.dart';

class ToDoDatabase {

  List toDoList = [];


  //llamar hive
  final _mybox = Hive.box('task_db');
 
 void createInitialData(){
  toDoList = [
    ["Crea", false],
    ["Task", false]
  ];
 }

//Load data
void loadData(){
  toDoList = _mybox.get("TODOLIST");
}

void updateData(){
 _mybox.put('TODOLIST', toDoList);
}



}