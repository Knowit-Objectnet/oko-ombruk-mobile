import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:ombruk/models/CalendarEvent.dart' as model;
import 'package:ombruk/repositories/CalendarRepository.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository calendarRepository;

  CalendarBloc({@required this.calendarRepository})
      : assert(calendarRepository != null);

  @override
  CalendarState get initialState => CalendarInitial();

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) async* {
    switch (event.runtimeType) {
      case CalendarInitialEventsRequested:
        yield CalendarInitialLoadInProgress();
        try {
          final List<model.CalendarEvent> events =
              await calendarRepository.getEvents();
          yield CalendarLoadSuccess(calendarEvents: events);
        } catch (_) {
          yield CalendarLoadFailure();
        }
        break;
      case CalendarRefreshRequested:
        yield CalendarRefreshInProgress();
        try {
          final List<model.CalendarEvent> events =
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

class CalendarRefreshInProgress extends CalendarState {}

class CalendarLoadSuccess extends CalendarState {
  final List<model.CalendarEvent> calendarEvents;
  const CalendarLoadSuccess({@required this.calendarEvents})
      : assert(calendarEvents != null);

  @override
  List<Object> get props => [calendarEvents];
}

class CalendarLoadFailure extends CalendarState {}

//* Events

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarInitialEventsRequested extends CalendarEvent {}

class CalendarRefreshRequested extends CalendarEvent {}
