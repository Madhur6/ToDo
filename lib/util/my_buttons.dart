import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  MyButtons({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text),
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
    );
  }
}