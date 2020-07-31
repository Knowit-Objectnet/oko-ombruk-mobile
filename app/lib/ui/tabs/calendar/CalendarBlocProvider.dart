import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';

import 'package:ombruk/ui/tabs/TokenHolder.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';

class CalendarBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String token = TokenHolder.of(context).token;
    final CalendarApiClient calendarApiClient = CalendarApiClient(token);

    return BlocProvider(
      create: (context) => CalendarBloc(calendarApiClient: calendarApiClient)
        ..add(CalendarInitialEventsRequested()),
      child: CalendarBlocBuilder(),
    );
  }
}
