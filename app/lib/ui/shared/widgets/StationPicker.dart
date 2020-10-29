import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/viewmodel/StationViewModel.dart';
import 'package:provider/provider.dart';

// DEPRECATED
class StationPicker extends StatelessWidget {
  final Station selectedStation;
  final ValueChanged<Station> stationChanged;
  final Color backgroundColor;

  StationPicker({
    @required this.selectedStation,
    @required this.stationChanged,
    this.backgroundColor = CustomColors.osloWhite,
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
              child: CustomIcons.image(CustomIcons.map)),
          Container(
            child: DropdownButton<Station>(
              value: selectedStation,
              hint: Text('Velg stasjon'),
              onChanged: stationChanged,
              underline: Container(),
              items: [],
              // items: stationViewModel.stations
              //     .map((station) => DropdownMenuItem(
              //           value: station,
              //           child: Text(station.name ?? ''),
              //         ))
              //     .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:meta/meta.dart';
// import 'package:flutter/material.dart';
// import 'package:ombruk/models/Station.dart';
// import 'package:ombruk/ui/shared/const/CustomColors.dart';
// import 'package:ombruk/ui/shared/const/CustomIcons.dart';
// import 'package:ombruk/viewmodel/StationViewModel.dart';
// import 'package:provider/provider.dart';

// class StationPicker extends StatelessWidget {
//   final Station selectedStation;
//   final ValueChanged<Station> stationChanged;
//   final Color backgroundColor;

//   StationPicker({
//     @required this.selectedStation,
//     @required this.stationChanged,
//     this.backgroundColor = CustomColors.osloWhite,
//   }) : assert(stationChanged != null);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: backgroundColor,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: CustomIcons.image(CustomIcons.map)),
//           Container(
//             child: Consumer<StationViewModel>(
//               builder: (context, stationViewModel, _) {
//                 return DropdownButton<Station>(
//                   value: selectedStation,
//                   hint: Text('Velg stasjon'),
//                   onChanged: stationChanged,
//                   underline: Container(),
//                   items: stationViewModel.stations
//                       .map((station) => DropdownMenuItem(
//                             value: station,
//                             child: Text(station.name ?? ''),
//                           ))
//                       .toList(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
