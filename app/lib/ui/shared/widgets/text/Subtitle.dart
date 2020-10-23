import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String text;
  Subtitle({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
