import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/repositories/CalendarRepository.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';

class CalendarBlocProvider extends StatelessWidget {
  final CalendarRepository calendarRepository =
      CalendarRepository(apiClient: CalendarApiClient());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarBloc(calendarRepository: calendarRepository)
        ..add(CalendarInitialEventsRequested()),
      child: CalendarBlocBuilder(),
    );
  }
}
