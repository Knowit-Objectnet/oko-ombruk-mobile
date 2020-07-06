import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/repositories/CalendarRepository.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';

class CalendarRouter extends StatefulWidget {
  @override
  _CalendarRouterState createState() => _CalendarRouterState();
}

class _CalendarRouterState extends State<CalendarRouter> {
  final CalendarRepository calendarRepository =
      CalendarRepository(apiClient: CalendarApiClient());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            CalendarBloc(calendarRepository: calendarRepository)
              ..add(CalendarInitialEventsRequested()),
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case CalendarInitial:
              case CalendarInitialLoadInProgress:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case CalendarRefreshInProgress:
              case CalendarLoadSuccess:
                return CalendarScreen(
                    events: (state as CalendarLoadSuccess).calendarEvents);
              case CalendarLoadFailure:
                return Center(
                  child: Text('Kunne ikke laste inn kalenderen'),
                );
              default:
                return Container();
            }
          },
        ));
  }
}
