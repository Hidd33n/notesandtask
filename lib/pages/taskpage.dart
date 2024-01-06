import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes/data/taskhive_db.dart';
import 'package:notes/models/todotile.dart';
import 'package:notes/pages/ui/newtaskdialog.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  //Hive box
  final _mybox = Hive.box('task_db');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_mybox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

//control
  final _controller = TextEditingController();

//Check

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

//Guardar tarea
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateData();
  }

//crear nueva tarea
  void createNewTask() {
    showDialog(
        context: context,
        builder: ((context) {
          return NewTaskDialg(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        }));
  }

//Eliminar tarea
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.black),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        elevation: 0.20,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: createNewTask,
        elevation: 0,
        backgroundColor: Colors.black87,
        label: const Text(
          'Add New Task',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.task_alt_outlined,
          color: Colors.white,
        ),
      ),
      body: db.toDoList.isEmpty
          ? Center(
              child: Text(
                'Create new task.. :c',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskComplete: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (p0) => deleteTask(index),
                );
              },
            ),
    );
  }
}
