import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  // CalendarBloc({@required })

  @override
  CalendarState get initialState => CalendarInitial();

  @override
  Stream<CalendarState> mapEventToState(CalendarEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
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

//* Events

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarOpened extends CalendarEvent {}
