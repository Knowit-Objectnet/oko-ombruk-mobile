import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/CacheService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/mixins/UseCache.dart';

abstract class ICalendarService with UseCache {
  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(EventGetForm form);

  Future<CustomResponse> createCalendarEvent(EventPostForm form);

  Future<CustomResponse> deleteCalendarEvent(EventDeleteForm form);

  Future<CustomResponse<CalendarEvent>> updateEvent(EventUpdateForm form);
  void updateDependencies(IApi api, CacheService _cacheService);
}
