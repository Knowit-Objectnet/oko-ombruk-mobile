import 'dart:convert';
import 'package:ombruk/const/ApiEndpoint.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/CacheService.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';

class CalendarService implements ICalendarService {
  IApi _api;
  CacheService _cacheService;
  CalendarService(this._api, this._cacheService) {
    print("init");
  }

  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(
    EventGetForm form, {
    Function(CustomResponse<List<CalendarEvent>>) newDataCallback,
  }) async {
    final CustomResponse response = await _cacheService.getRequest(
        form, ApiEndpoint.events,
        newDataCallback: newDataCallback, parser: _parseResult);

    if (!response.success) {
      return response;
    }

    return _parseResult(response);
  }

  void updateDependencies(IApi api, CacheService _cacheService) {
    this._api = api;
    this._cacheService = _cacheService;
  }

  CustomResponse<List<CalendarEvent>> _parseResult(CustomResponse response) {
    try {
      List<CalendarEvent> events = List<dynamic>.from(jsonDecode(response.data))
          .map((event) => CalendarEvent.fromJson(event))
          .toList();
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: events,
      );
    } catch (error) {
      return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: "$error ${response.data}");
    }
  }

  Future<CustomResponse> createCalendarEvent(EventPostForm form) async =>
      await _cacheService.postRequest(ApiEndpoint.events, form);

  /// Returns a CustomResponse with null data
  Future<CustomResponse> deleteCalendarEvent(EventDeleteForm form) async =>
      await _cacheService.deleteRequest(ApiEndpoint.events, form);

  /// Returns a CustomResponse with null data
  Future<CustomResponse<CalendarEvent>> updateEvent(
      EventUpdateForm form) async {
    CustomResponse response = await _api.patchRequest(ApiEndpoint.events, form);
    if (!response.success) {
      return response;
    }
    print(List<dynamic>.from(jsonDecode(response.data)));
    try {
      CalendarEvent event = CalendarEvent.fromJson(jsonDecode(response.data));
      return CustomResponse(
          success: true, statusCode: response.statusCode, data: event);
    } catch (e) {
      return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: e.toString());
    }
  }

  @override
  void removeCallback(Function function) {
    _cacheService.removeCallback(function, ApiEndpoint.events);
  }
}
