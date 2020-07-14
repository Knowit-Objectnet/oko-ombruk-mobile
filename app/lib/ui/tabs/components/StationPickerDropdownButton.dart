import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class StationPickerDropdownButton extends StatelessWidget {
  final String selectedStation;
  final ValueChanged<String> stationChanged;

  StationPickerDropdownButton(
      {@required this.selectedStation, @required this.stationChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Image.asset('assets/icons/kart.png', height: 20, width: 20)),
        Container(
          // color: , // TODO
          child: DropdownButton<String>(
            value: selectedStation,
            onChanged: stationChanged,
            underline: Container(),
            items: globals.stations
                .map((station) => DropdownMenuItem(
                      value: station,
                      child: Text(station),
                    ))
                .toList(),
          ),
        )
      ],
    );
  }
}
