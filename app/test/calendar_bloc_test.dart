import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/models/CustomResponse.dart';

class MockCalendarApiClient extends Mock implements CalendarApiClient {}

CalendarBloc calendarBloc;
MockCalendarApiClient mockCalendarApiClient;

void main() {
  setUp(() {
    mockCalendarApiClient = MockCalendarApiClient();
    calendarBloc = CalendarBloc(calendarApiClient: mockCalendarApiClient);
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
      final CustomResponse<List<CalendarEvent>> response =
          CustomResponse<List<CalendarEvent>>(
        success: true,
        statusCode: 200,
        data: <CalendarEvent>[],
      );

      when(mockCalendarApiClient.fetchEvents())
          .thenAnswer((_) => Future.value(response));

      expectLater(
        calendarBloc,
        emitsInOrder([
          CalendarInitial(),
          CalendarInitialLoadInProgress(),
          CalendarLoadSuccess(calendarEvents: response.data),
        ]),
      );

      calendarBloc.add(CalendarInitialEventsRequested());
    });

    test('Failed initial fetch', () {
      final CustomResponse<List<CalendarEvent>> response =
          CustomResponse<List<CalendarEvent>>(
        success: false,
        statusCode: 400,
        data: null,
      );

      when(mockCalendarApiClient.fetchEvents())
          .thenAnswer((_) => Future.value(response));

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
