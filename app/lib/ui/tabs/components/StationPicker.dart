import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class StationPicker extends StatelessWidget {
  final String selectedStation;
  final ValueChanged<String> stationChanged;
  final Color backgroundColor;

  StationPicker({
    @required this.selectedStation,
    @required this.stationChanged,
    this.backgroundColor = customColors.osloWhite,
  }) : assert(stationChanged != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 8.0),
              child:
                  Image.asset('assets/icons/kart.png', height: 20, width: 20)),
          Container(
            child: DropdownButton<String>(
              value: selectedStation,
              hint: Text('Velg stasjon'),
              onChanged: stationChanged,
              underline: Container(),
              items: globals.stations
                  .map((station) => DropdownMenuItem(
                        value: station,
                        child: Text(station),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
