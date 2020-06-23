import 'package:flutter/material.dart';

class StationFilter extends StatefulWidget {
  @override
  _StationFilterState createState() => _StationFilterState();
}

class _StationFilterState extends State<StationFilter> {
  final List<String> stations = ['Haraldrud', 'Smestad', 'Grønmo'];

  @override
  Widget build(BuildContext context) {
    return (Wrap(
      direction: Axis.horizontal,
      children: stations
          .map((e) => CheckboxListTile(
                title: Text(e),
                value: true,
                onChanged: null,
              ))
          .toList()
          .cast<Widget>(),
    ));
  }
}
