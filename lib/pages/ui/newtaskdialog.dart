import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/pages/ui/taskbuttons.dart';

// ignore: must_be_immutable
class NewTaskDialg extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  NewTaskDialg({super.key, required this.controller, required this.onSave, required this.onCancel}) {
    // Restablecer el controlador para que esté vacío cuando se abre el diálogo
    controller.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Add a new task'),
            ),
            // Botones guardar y cancelar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Boton de guardar
                TaskButtons(
                  text: "Save",
                  onPressed: onSave,
                ),
                // Boton de cancelar
                TaskButtons(
                  text: "Cancel",
                  onPressed: onCancel,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
