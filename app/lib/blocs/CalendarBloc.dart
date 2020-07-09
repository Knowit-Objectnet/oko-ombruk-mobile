import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/repositories/CalendarRepository.dart';

class CalendarBloc extends Bloc<CalendarBlocEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({@required this.calendarRepository})
      : assert(calendarRepository != null);

  @override
  CalendarState get initialState => CalendarInitial();

  @override
  Stream<CalendarState> mapEventToState(CalendarBlocEvent event) async* {
    switch (event.runtimeType) {
      case CalendarInitialEventsRequested:
        yield CalendarInitialLoadInProgress();
        try {
          final List<CalendarEvent> events =
              await calendarRepository.getEvents();
          yield CalendarLoadSuccess(calendarEvents: events);
        } catch (_) {
          yield CalendarLoadFailure();
        }
        break;
      case CalendarRefreshRequested:
        final List<CalendarEvent> events =
            (state as CalendarLoadSuccess).calendarEvents;
        yield CalendarRefreshInProgress(calendarEvents: events);
        try {
          final List<CalendarEvent> events =
              await calendarRepository.getEvents();
          yield CalendarLoadSuccess(calendarEvents: events);
        } catch (_) {
          yield CalendarLoadFailure();
        }
        break;
    }
  }
}

//* States

abstract class CalendarState extends Equatable {
  const CalendarState();

  // Equatale: to compare two instances of CalendarState. By default, == returns true only if the two objects are the same instance.
  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarInitialLoadInProgress extends CalendarState {}

class CalendarRefreshInProgress extends CalendarState {
  final List<CalendarEvent> calendarEvents;
  const CalendarRefreshInProgress({@required this.calendarEvents})
      : assert(calendarEvents != null);

  @override
  List<Object> get props => [calendarEvents];
}

class CalendarLoadSuccess extends CalendarState {
  final List<CalendarEvent> calendarEvents;
  const CalendarLoadSuccess({@required this.calendarEvents})
      : assert(calendarEvents != null);

  @override
  List<Object> get props => [calendarEvents];
}

class CalendarLoadFailure extends CalendarState {}

//* Events

abstract class CalendarBlocEvent extends Equatable {
  const CalendarBlocEvent();

  @override
  List<Object> get props => [];
}

class CalendarInitialEventsRequested extends CalendarBlocEvent {}

class CalendarRefreshRequested extends CalendarBlocEvent {}
