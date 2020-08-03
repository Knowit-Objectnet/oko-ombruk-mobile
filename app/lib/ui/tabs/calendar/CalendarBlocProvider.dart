import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';
import 'package:provider/provider.dart';

class CalendarBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, UserViewModel userViewModel, child) {
      return BlocProvider(
        create: (context) => CalendarBloc(
            calendarApiClient: CalendarApiClient(userViewModel.accessToken))
          ..add(CalendarInitialEventsRequested()),
        child: CalendarBlocBuilder(),
      );
    });
  }
}
