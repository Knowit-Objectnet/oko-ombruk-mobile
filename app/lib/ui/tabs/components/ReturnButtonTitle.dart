import 'package:flutter/material.dart';

class ReturnButtonTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  ReturnButtonTitle(this.title, {this.fontSize = 18.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
