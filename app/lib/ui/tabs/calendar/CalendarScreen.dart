import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/views/BaseWidget.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/CalendarViewModel.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/ui.helper.dart';

class CalendarScreen extends StatelessWidget {
  bool _showHorizontalCalendar = true;
  get verticalCalendar => _showHorizontalCalendar;

  List<CalendarEvent> _getFilteredList(CalendarViewModel model) {
    if (model.calendarEvents == null) {
      return [];
    }
    if (model.selectedStation == null) {
      return [];
    }
    return model.calendarEvents
        .where((element) => element.station.name == model.selectedStation.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: CalendarViewModel(Provider.of(context), Provider.of(context)),
      onModelReady: (CalendarViewModel model) => model.start(),
      builder: (context, CalendarViewModel model, _) => Container(
        child: model.state == ViewState.Busy
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Use DropdownButton instead if the design fails
                      PopupMenuButton(
                        child: Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: customIcons.image(customIcons.filter,
                                    size: 15)),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  model.selectedStation?.name ?? '',
                                  style: TextStyle(fontSize: 16),
                                )),
                            customIcons.image(customIcons.arrowDownThin,
                                size: 15)
                          ],
                        ),
                        itemBuilder: (context) => model.stations
                            .map((Station station) => PopupMenuItem(
                                  child: RadioListTile<Station>(
                                    title: Text(station.name ?? ''),
                                    value: station,
                                    groupValue: model.selectedStation,
                                    onChanged: (value) {
                                      model.onStationChanged(value);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                      Spacer(),
                    ],
                  ),
                  Expanded(
                      child: (_showHorizontalCalendar)
                          ? HorizontalCalendar(events: _getFilteredList(model))
                          : VerticalCalendar(events: _getFilteredList(model))),
                ],
              ),
      ),
    );
  }
}

// class CalendarScreee extends StatelessWidget {
//   // State key
//   final Key globalKey;
//   const CalendarScreee({this.globalKey});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer3<UserViewModel, CalendarViewModel, StationViewModel>(
//       builder: (
//         context,
//         UserViewModel userViewModel,
//         CalendarViewModel calendarViewModel,
//         StationViewModel stationViewModel,
//         child, // Not the most optimal way of doing things... should have a child
//       ) {
//         return _CalendarScreenConsumed(
//           userViewModel: userViewModel,
//           calendarViewModel: calendarViewModel,
//           stationViewModel: stationViewModel,
//           key: this.globalKey,
//         );
//       },
//     );
//   }
// }

// class _CalendarScreenConsumed extends StatefulWidget {
//   final UserViewModel userViewModel;
//   final CalendarViewModel calendarViewModel;
//   final StationViewModel stationViewModel;
//   final Key key;

//   _CalendarScreenConsumed({
//     @required this.userViewModel,
//     @required this.calendarViewModel,
//     this.stationViewModel,
//     this.key,
//   })  : assert(userViewModel != null),
//         assert(calendarViewModel != null),
//         assert(stationViewModel != null);

//   @override
//   CalendarScreenConsumedState createState() => CalendarScreenConsumedState();
// }

// class CalendarScreenConsumedState extends State<_CalendarScreenConsumed>
//     with SingleTickerProviderStateMixin {
//   AnimationController _rotationController;

//   bool _initialized = false;
//   bool _showHorizontalCalendar = true;
//   Station _selectedStation;

//   @override
//   void initState() {
//     super.initState();
//     _rotationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 2))
//           ..repeat();
//   }

//   @override
//   void dispose() {
//     _rotationController.dispose();
//     super.dispose();
//   }

//   get verticalCalendar => _showHorizontalCalendar;

//   void toggleCalendar() {
//     setState(() {
//       _showHorizontalCalendar = !_showHorizontalCalendar;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.stationViewModel.stations.isNotEmpty && !_initialized) {
//       // Hotfix to get the dropdown to have a first time value
//       setState(() {
//         _initialized = true;
//         _selectedStation = widget.stationViewModel.stations[0];
//       });
//     }
//     return Scaffold(
//         body: Container(
//       color: customColors.osloWhite,
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               // Use DropdownButton instead if the design fails
//               widget.stationViewModel == null
//                   ? Container()
//                   : PopupMenuButton(
//                       child: Row(
//                         children: <Widget>[
//                           Padding(
//                               padding: EdgeInsets.only(left: 8.0),
//                               child: customIcons.image(customIcons.filter,
//                                   size: 15)),
//                           Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 4.0),
//                               child: Text(
//                                 _selectedStation?.name ?? '',
//                                 style: TextStyle(fontSize: 16),
//                               )),
//                           customIcons.image(customIcons.arrowDownThin, size: 15)
//                         ],
//                       ),
//                       itemBuilder: (context) => widget.stationViewModel.stations
//                           .map((Station station) => PopupMenuItem(
//                                 child: RadioListTile<Station>(
//                                   title: Text(station.name ?? ''),
//                                   value: station,
//                                   groupValue: _selectedStation,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _selectedStation = value;
//                                     });
//                                     Navigator.pop(context);
//                                   },
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//               Spacer(),
//               /*_headerButton(
//                   icon: _showHorizontalCalendar
//                       ? customIcons.list
//                       : customIcons.calendar,
//                   onPressed: () => setState(() {
//                     _showHorizontalCalendar = !_showHorizontalCalendar;
//                   }),
//                 ),
//                 widget.userViewModel.getRole() ==
//                         globals.KeycloakRoles.reuse_station
//                     ? _headerButton(
//                         icon: customIcons.add,
//                         onPressed: () async {
//                           final pickupCreated = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => AddExtraPickupScreen(),
//                               ));
//                           if (pickupCreated != null && pickupCreated) {
//                             uiHelper.showSnackbar(
//                                 context, 'Uttaket ble registrert');
//                           }
//                         },
//                       )
//                     : Container(),
//                 widget.userViewModel.getRole() ==
//                         globals.KeycloakRoles.reg_employee
//                     ? _headerButton(
//                         icon: customIcons.add,
//                         onPressed: _puchCreateOccurrenceScreen,
//                       )
//                     : Container(),
//                 widget.calendarViewModel.isLoading
//                     ? _headerButton(
//                         icon: customIcons.refresh,
//                         onPressed: null,
//                         isSpinning: true,
//                       )
//                     : _headerButton(
//                         icon: customIcons.refresh,
//                         onPressed: _refreshCalendar,
//                       )*/
//             ],
//           ),
//           Expanded(
//               child: (_showHorizontalCalendar)
//                   ? HorizontalCalendar(events: _getFilteredList())
//                   : VerticalCalendar(events: _getFilteredList())),
//         ],
//       ),
//     ));
//   }

//   Widget _headerButton({
//     @required String icon,
//     @required Function() onPressed,
//     bool isSpinning = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(left: 0, right: 8.0, top: 8.0, bottom: 8.0),
//       child: CircleAvatar(
//         backgroundColor: customColors.osloGreen,
//         child: isSpinning
//             ? RotationTransition(
//                 turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
//                 child: IconButton(
//                   icon: customIcons.image(icon),
//                   onPressed: () => null,
//                 ),
//               )
//             : IconButton(
//                 icon: customIcons.image(icon),
//                 onPressed: onPressed,
//               ),
//       ),
//     );
//   }

//   List<CalendarEvent> _getFilteredList() {
//     if (widget.calendarViewModel.calendarEvents == null) {
//       return [];
//     }
//     if (_selectedStation == null) {
//       return [];
//     }
//     return widget.calendarViewModel.calendarEvents
//         .where((element) => element.station.name == _selectedStation.name)
//         .toList();
//   }

//   Future<void> _refreshCalendar() async {
//     widget.calendarViewModel.fetchEvents();
//   }

// // Only available to REG employees
//   Future<void> _puchCreateOccurrenceScreen() async {
//     final bool occurrenceAdded = await Navigator.push(
//       context,
//       MaterialPageRoute<bool>(
//         builder: (context) => CreateOccurrenceScreen(),
//       ),
//     );
//     if (occurrenceAdded) {
//       uiHelper.showSnackbar(context, 'Opprettet hendelsen!');
//       widget.calendarViewModel.fetchEvents();
//     }
//   }
// }
