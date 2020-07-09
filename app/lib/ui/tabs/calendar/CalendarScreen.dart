import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.dispose();
    _rotationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        child: Icon(Icons.filter_list)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          _selectedStation,
                          style: TextStyle(fontSize: 16),
                        )),
                    Icon(Icons.arrow_downward),
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
                    ? Icon(Icons.list)
                    : Icon(Icons.calendar_today),
                onPressed: () => setState(() {
                  _showHorizontalCalendar = !_showHorizontalCalendar;
                }),
              ),
              widget.isLoading
                  ? RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0)
                          .animate(_rotationController),
                      child: IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => null,
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.refresh),
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
