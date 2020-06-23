import 'package:flutter/material.dart';

class StationFilter extends StatefulWidget {
  StationFilter({Key key, @required this.stations}) : super(key: key);

  final List<String> stations;

  @override
  _StationFilterState createState() => _StationFilterState();
}

class _StationFilterState extends State<StationFilter> {
  Map<String, bool> stationValues;

  @override
  void initState() {
    print(widget.stations);
    setState(() {
      stationValues = Map<String, bool>.fromIterable(widget.stations,
          key: (item) => item, value: (item) => true);
    });
    print(stationValues == null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (stationValues == null
        ? Container()
        : Wrap(
            direction: Axis.horizontal,
            children: stationValues.entries
                .map((e) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(e.key),
                        Checkbox(
                          value: e.value,
                          onChanged: (bool newValue) {
                            setState(() {
                              stationValues[e.key] = newValue;
                            });
                          },
                        )
                      ],
                    ))
                .toList()
                .cast<Widget>(),
          ));
  }
}
