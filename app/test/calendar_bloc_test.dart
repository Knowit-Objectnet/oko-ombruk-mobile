import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/repositories/CalendarRepository.dart';

class MockCalendarRepository extends Mock implements CalendarRepository {}

CalendarBloc calendarBloc;
MockCalendarRepository mockCalendarRepository;

void main() {
  setUp(() {
    mockCalendarRepository = MockCalendarRepository();
    calendarBloc = CalendarBloc(calendarRepository: mockCalendarRepository);
  });

  tearDown(() {
    calendarBloc?.close();
  });

  test('initial state is correct', () {
    expect(calendarBloc.initialState, CalendarInitial());
  });

  test('close does not emit new states', () {
    expectLater(
      calendarBloc,
      emitsInOrder([CalendarInitial(), emitsDone]),
    );
    calendarBloc.close();
  });

  group('Fetching of events', () {
    test('Successful initial fetch', () {
      final List<CalendarEvent> events = [];

      when(mockCalendarRepository.getEvents())
          .thenAnswer((_) => Future.value(events));

      expectLater(
        calendarBloc,
        emitsInOrder([
          CalendarInitial(),
          CalendarInitialLoadInProgress(),
          CalendarLoadSuccess(calendarEvents: events)
        ]),
      );

      calendarBloc.add(CalendarInitialEventsRequested());
    });

    test('Failed initial fetch', () {
      when(mockCalendarRepository.getEvents()).thenThrow(Error);

      expectLater(
        calendarBloc,
        emitsInOrder([
          CalendarInitial(),
          CalendarInitialLoadInProgress(),
          CalendarLoadFailure()
        ]),
      );

      calendarBloc.add(CalendarInitialEventsRequested());
    });
  });
}
