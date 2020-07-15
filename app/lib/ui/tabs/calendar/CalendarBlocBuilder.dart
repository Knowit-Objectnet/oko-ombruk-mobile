import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';

class CalendarBlocBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case CalendarInitial:
          case CalendarInitialLoadInProgress:
            return Center(
              child: CircularProgressIndicator(),
            );
          case CalendarRefreshInProgress:
            return CalendarScreen(
              isLoading: true,
              events: (state as CalendarRefreshInProgress).calendarEvents,
            );
          case CalendarLoadSuccess:
            return CalendarScreen(
                isLoading: false,
                events: (state as CalendarLoadSuccess).calendarEvents);
          case CalendarLoadFailure:
            return Center(
              child: Text('Kunne ikke laste inn kalenderen'),
            );
          default:
            return Container();
        }
      },
    );
  }
}
