import 'package:meta/meta.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/models/CalendarEvent.dart';

class CalendarRepository {
  final CalendarApiClient apiClient;

  CalendarRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List<CalendarEvent>> getEvents() async {
    return await apiClient.fetchEvents();
  }
}
