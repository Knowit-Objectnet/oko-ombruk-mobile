import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/calendar/HorizontalCalendar/HorizontalCalendar.dart';
import 'package:ombruk/ui/tabs/calendar/VerticalCalendar/VerticalCalendar.dart';

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
        // mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
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
