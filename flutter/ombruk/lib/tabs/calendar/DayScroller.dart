import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/DateButton.dart';

class DayScroller extends StatefulWidget {
  @override
  _DayScrollerState createState() => _DayScrollerState();
}

class _DayScrollerState extends State<DayScroller> {
  @override
  Widget build(BuildContext context) {
    return (Container(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) => DateButton(index: index))));
  }
}
