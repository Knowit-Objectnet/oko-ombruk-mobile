import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:ombruk/models/WeightEvent.dart';
import 'package:ombruk/repositories/WeightReportRepository.dart';

class WeightReportBloc extends Bloc<WeightReportEvent, WeightReportState> {
  final WeightReportRepository weightReportRepository;

  WeightReportBloc({@required this.weightReportRepository})
      : assert(weightReportRepository != null);

  @override
  WeightReportState get initialState => WeightReportInitial();

  @override
  Stream<WeightReportState> mapEventToState(WeightReportEvent event) async* {
    switch (event.runtimeType) {
      case WeightReportLoadRequested:
        try {
          final List<WeightEvent> weightEvents =
              await weightReportRepository.getWeightEvents();
          yield WeightReportLoadSuccess(weightEvents: weightEvents);
        } catch (_) {
          yield WeightReportLoadFailure();
        }
    }
  }
}

abstract class WeightReportState extends Equatable {
  const WeightReportState();

  // Equatale: to compare two instances of CalendarState. By default, == returns true only if the two objects are the same instance.
  @override
  List<Object> get props => [];
}

//* States

class WeightReportInitial extends WeightReportState {}

class WeightReportLoadSuccess extends WeightReportState {
  final List<WeightEvent> weightEvents;

  const WeightReportLoadSuccess({@required this.weightEvents})
      : assert(weightEvents != null);

  @override
  List<Object> get props => [weightEvents];
}

class WeightReportLoadFailure extends WeightReportState {}

// class WeightRefreshInProgress extends WeightReportState {}

//* Events

class WeightReportEvent extends Equatable {
  const WeightReportEvent();

  @override
  List<Object> get props => [];
}

class WeightReportLoadRequested extends WeightReportEvent {}
