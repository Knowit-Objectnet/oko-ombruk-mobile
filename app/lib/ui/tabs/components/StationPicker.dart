import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/StationViewModel.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class StationPicker extends StatelessWidget {
  final Station selectedStation;
  final ValueChanged<Station> stationChanged;
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
              child: customIcons.image(customIcons.map)),
          Container(
            child: Consumer<StationViewModel>(
              builder: (context, stationViewModel, _) {
                return DropdownButton<Station>(
                  value: selectedStation,
                  hint: Text('Velg stasjon'),
                  onChanged: stationChanged,
                  underline: Container(),
                  items: stationViewModel.stations
                      .map((station) => DropdownMenuItem(
                            value: station,
                            child: Text(station.name ?? ''),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
