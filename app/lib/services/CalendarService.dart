import 'dart:convert';
import 'package:ombruk/const/ApiEndpoint.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/ICacheService.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';
import 'package:ombruk/services/mixins/ParseResponse.dart';

class CalendarService with ParseResponse implements ICalendarService {
  ICacheService _cacheService;
  CalendarService(this._cacheService);

  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(
    EventGetForm form, {
    Function(CustomResponse<List<CalendarEvent>>) newDataCallback,
  }) async {
    final CustomResponse response = await _cacheService.getRequest(
      path: ApiEndpoint.events,
      form: form,
      newDataCallback: newDataCallback,
      parser: _parseResult,
    );

    return response.success ? _parseResult(response) : response;
  }

  CustomResponse<List<CalendarEvent>> _parseResult(CustomResponse res) {
    return parseList<CalendarEvent>(res, (e) => CalendarEvent.fromJson(e));
  }

  void updateDependencies(ICacheService _cacheService) {
    this._cacheService = _cacheService;
  }

  Future<CustomResponse> createCalendarEvent(EventPostForm form) async {
    CustomResponse response =
        await _cacheService.postRequest(ApiEndpoint.events, form);
    if (!response.success) {
      return response;
    }
    _cacheService.invalidateEndpoint(ApiEndpoint.weightReports);
    return response;
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse> deleteCalendarEvent(EventDeleteForm form) async {
    CustomResponse response =
        await _cacheService.deleteRequest(ApiEndpoint.events, form);
    if (!response.success) {
      return response;
    }

    _cacheService.invalidateEndpoint(ApiEndpoint.weightReports);
    return response;
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse<CalendarEvent>> updateEvent(
      EventUpdateForm form) async {
    CustomResponse response = await _cacheService.patchRequest(
      ApiEndpoint.events,
      form,
    );
    if (!response.success) {
      return response;
    }
    _cacheService.invalidateEndpoint(ApiEndpoint.weightReports);
    return parseObject<CalendarEvent>(
      response,
      (data) => CalendarEvent.fromJson(jsonDecode(data)),
    );
  }

  @override
  void removeCallback(Function function) {
    _cacheService.removeCallback(function, ApiEndpoint.events);
  }
}
