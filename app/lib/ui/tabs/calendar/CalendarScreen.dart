import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';
import 'package:ombruk/globals.dart' as globals;

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
      color: globals.osloWhite,
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
                        child: Image.asset('assets/icons/filter.png',
                            height: 15, width: 15)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          _selectedStation,
                          style: TextStyle(fontSize: 16),
                        )),
                    Image.asset('assets/icons/pil-tynn-ned.png',
                        height: 15, width: 15),
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
              IconButton(
                icon: _showHorizontalCalendar
                    ? Image.asset('assets/icons/listeikon.png',
                        height: 20, width: 20)
                    : Image.asset('assets/icons/kalender.png',
                        height: 20, width: 20),
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              role == globals.KeycloakRoles.reuse_station
                  ? IconButton(
                      icon: Image.asset('assets/icons/add.png',
                          height: 20, width: 20),
                      onPressed: () => null,
                    )
                  : Container(),
              widget.isLoading
                  ? RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0)
                          .animate(_rotationController),
                      child: IconButton(
                        icon: Image.asset('assets/icons/refresh.png',
                            height: 20, width: 20),
                        onPressed: () => null,
                      ),
                    )
                  : IconButton(
                      icon: Image.asset('assets/icons/refresh.png',
                          height: 20, width: 20),
                      onPressed: _refreshCalendar,
                    )
            ],
          ),
          Expanded(
              child: _showHorizontalCalendar
                  ? HorizontalCalendar(events: widget.events)
                  : VerticalCalendar(events: widget.events))
        ],
      ),
    );
  }

  Future<void> _refreshCalendar() async {
    BlocProvider.of<CalendarBloc>(context).add(CalendarRefreshRequested());
  }
}
