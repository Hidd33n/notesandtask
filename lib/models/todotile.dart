import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskComplete;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;


   ToDoTile({super.key, required this.taskName, required this.taskComplete, required this.onChanged, required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right:25, top: 25, ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),)
          ]),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
      
              //checkbox
              Checkbox(value: taskComplete,
              onChanged: onChanged,
              activeColor: Colors.black,),
      
      
              //nombre
              Text(taskName, style: TextStyle(decoration: taskComplete ? TextDecoration.lineThrough : TextDecoration.none),)
            ],
          ),
        ),
      ),

    );
  }
}