import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:ombruk/blocs/WeightReportBloc.dart';
import 'package:ombruk/models/WeightEvent.dart';
import 'package:ombruk/repositories/WeightReportRepository.dart';

class MockWeightReportRepository extends Mock
    implements WeightReportRepository {}

WeightReportBloc weightReportBloc;
MockWeightReportRepository mockWeightReportRepository;

void main() {
  setUp(() {
    mockWeightReportRepository = MockWeightReportRepository();
    weightReportBloc =
        WeightReportBloc(weightReportRepository: mockWeightReportRepository);
  });

  tearDown(() {
    weightReportBloc?.close();
  });

  test('initial state is correct', () {
    expect(weightReportBloc.initialState, WeightReportInitial());
  });

  group('Fetching of events', () {
    test('Successful weight event fetch', () {
      final List<WeightEvent> weightEvents = [];

      when(mockWeightReportRepository.getWeightEvents())
          .thenAnswer((_) => Future.value(weightEvents));

      expectLater(
        weightReportBloc,
        emitsInOrder([
          WeightReportInitial(),
          WeightReportLoadSuccess(weightEvents: weightEvents),
        ]),
      );

      weightReportBloc.add(WeightReportLoadRequested());
    });

    test('Failed weight event fetch', () {
      when(mockWeightReportRepository.getWeightEvents()).thenThrow(Error);

      expectLater(
        weightReportBloc,
        emitsInOrder([
          WeightReportInitial(),
          WeightReportLoadFailure(),
        ]),
      );

      weightReportBloc.add(WeightReportLoadRequested());
    });
  });
}
