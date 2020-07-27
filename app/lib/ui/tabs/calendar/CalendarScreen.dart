import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class CalendarScreen extends StatefulWidget {
  final List<CalendarEvent> events;
  final bool isLoading;

  CalendarScreen({@required this.events, @required this.isLoading})
      : assert(events != null);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _rotationController;
  globals.KeycloakRoles role;

  bool _showHorizontalCalendar = true;
  String _selectedStation = globals.stations[0];

  @override
  void initState() {
    super.initState();
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
    role = context.bloc<AuthenticationBloc>().userRepository.getRole();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customColors.osloWhite,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Use DropdownButton instead if the design fails
              PopupMenuButton(
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: customIcons.image(customIcons.filter, size: 15)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          _selectedStation,
                          style: TextStyle(fontSize: 16),
                        )),
                    customIcons.image(customIcons.arrowDownThin, size: 15)
                  ],
                ),
                itemBuilder: (context) => globals.stations
                    .map((String station) => PopupMenuItem(
                          child: RadioListTile(
                            title: Text(station),
                            value: station,
                            groupValue: _selectedStation,
                            onChanged: (String value) {
                              setState(() {
                                _selectedStation = value;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        ))
                    .toList(),
              ),
              Spacer(),
              RawMaterialButton(
                fillColor: customColors.osloGreen,
                shape: CircleBorder(),
                child: _showHorizontalCalendar
                    ? customIcons.image(customIcons.list)
                    : customIcons.image(customIcons.calendar),
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              role == globals.KeycloakRoles.reuse_station
                  ? RawMaterialButton(
                      fillColor: customColors.osloGreen,
                      shape: CircleBorder(),
                      child: customIcons.image(customIcons.add),
                      onPressed: () => null,
                    )
                  : Container(),
              widget.isLoading
                  ? RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0)
                          .animate(_rotationController),
                      child: RawMaterialButton(
                        fillColor: customColors.osloGreen,
                        shape: CircleBorder(),
                        child: customIcons.image(customIcons.refresh),
                        onPressed: () => null,
                      ),
                    )
                  : RawMaterialButton(
                      fillColor: customColors.osloGreen,
                      shape: CircleBorder(),
                      child: customIcons.image(customIcons.refresh),
                      onPressed: _refreshCalendar,
                    ),
            ],
          ),
          Expanded(
              child: _showHorizontalCalendar
                  ? HorizontalCalendar(events: _getFilteredList())
                  : VerticalCalendar(events: _getFilteredList()))
        ],
      ),
    );
  }

  List<CalendarEvent> _getFilteredList() {
    return widget.events
        .where((element) => element.station.name == _selectedStation)
        .toList();
  }

  Future<void> _refreshCalendar() async {
    BlocProvider.of<CalendarBloc>(context).add(CalendarRefreshRequested());
  }
}
