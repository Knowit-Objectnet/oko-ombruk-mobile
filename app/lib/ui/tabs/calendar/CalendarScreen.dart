import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/CalendarViewModel.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/models/CalendarEvent.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateOccurrenceScreen.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';
import 'package:ombruk/ui/tabs/stasjonComponents/AddExtraPickupScreen.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/ui.helper.dart';

import 'package:ombruk/globals.dart' as globals;

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserViewModel, CalendarViewModel>(
      builder: (
        context,
        UserViewModel userViewModel,
        CalendarViewModel calendarViewModel,
        _,
      ) {
        return _CalendarScreenConsumed(
          userViewModel: userViewModel,
          calendarViewModel: calendarViewModel,
        );
      },
    );
  }
}

class _CalendarScreenConsumed extends StatefulWidget {
  final UserViewModel userViewModel;
  final CalendarViewModel calendarViewModel;

  _CalendarScreenConsumed(
      {@required this.userViewModel, @required this.calendarViewModel})
      : assert(userViewModel != null),
        assert(calendarViewModel != null);

  @override
  _CalendarScreenConsumedState createState() => _CalendarScreenConsumedState();
}

class _CalendarScreenConsumedState extends State<_CalendarScreenConsumed>
    with SingleTickerProviderStateMixin {
  AnimationController _rotationController;

  bool _showHorizontalCalendar = true;
  String _selectedStation = globals.stations[0];

  @override
  void initState() {
    super.initState();
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat();
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
              _headerButton(
                icon: _showHorizontalCalendar
                    ? customIcons.list
                    : customIcons.calendar,
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              widget.userViewModel.getRole() ==
                      globals.KeycloakRoles.reuse_station
                  ? _headerButton(
                      icon: customIcons.add,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddExtraPickupScreen(),
                            ));
                      },
                    )
                  : Container(),
              widget.userViewModel.getRole() ==
                      globals.KeycloakRoles.reg_employee
                  ? _headerButton(
                      icon: customIcons.add,
                      onPressed: _puchCreateOccurenceScreen,
                    )
                  : Container(),
              widget.calendarViewModel.isLoading
                  ? _headerButton(
                      icon: customIcons.refresh,
                      onPressed: null,
                      isSpinning: true,
                    )
                  : _headerButton(
                      icon: customIcons.refresh,
                      onPressed: _refreshCalendar,
                    )
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

  Widget _headerButton({
    @required String icon,
    @required Function() onPressed,
    bool isSpinning = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 0, right: 8.0, top: 8.0, bottom: 8.0),
      child: CircleAvatar(
        backgroundColor: customColors.osloGreen,
        child: isSpinning
            ? RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_rotationController),
                child: IconButton(
                  icon: customIcons.image(icon),
                  onPressed: () => null,
                ),
              )
            : IconButton(
                icon: customIcons.image(icon),
                onPressed: onPressed,
              ),
      ),
    );
  }

  List<CalendarEvent> _getFilteredList() {
    if (widget.calendarViewModel.calendarEvents == null) {
      return [];
    }
    return widget.calendarViewModel.calendarEvents
        .where((element) => element.station.name == _selectedStation)
        .toList();
  }

  Future<void> _refreshCalendar() async {
    widget.calendarViewModel.fetchEvents();
  }

// Only available to REG employees
  Future<void> _puchCreateOccurenceScreen() async {
    final bool occurrenceAdded = await Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (context) => CreateOccurrenceScreen(),
      ),
    );
    if (occurrenceAdded) {
      uiHelper.showSnackbar(context, 'Opprettet hendelsen!');
      widget.calendarViewModel.fetchEvents();
    }
  }
}
