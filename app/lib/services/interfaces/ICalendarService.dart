import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';

abstract class ICalendarService {
  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(
    EventGetForm form, {
    Function(CustomResponse<List<CalendarEvent>>) newDataCallback,
  });

  Future<CustomResponse> createCalendarEvent(EventPostForm form);

  Future<CustomResponse> deleteCalendarEvent(EventDeleteForm form);

  Future<CustomResponse<CalendarEvent>> updateEvent(EventUpdateForm form);
  void updateDependencies(ICacheService _cacheService);

  void removeCallback(Function function);
}
