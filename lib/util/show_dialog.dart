import 'package:flutter/material.dart';
import 'package:todoapp/util/my_buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            // take user's input
            TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
            ),

            // button -> save & cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // save button
                MyButtons(text: 'save', onPressed: onSave),

                // gap in-between
                const SizedBox(width: 8,),

                // cancel button
                MyButtons(text: 'cancel', onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}