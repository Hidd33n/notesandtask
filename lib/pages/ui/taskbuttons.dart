import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskButtons extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  TaskButtons({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.black, textColor: Colors.white,
      child: Text(text),
    );
  }
}