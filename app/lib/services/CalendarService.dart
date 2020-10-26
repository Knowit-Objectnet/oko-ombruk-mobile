import 'dart:convert';
import 'package:ombruk/const/ApiEndpoint.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/forms/Event/EventDeleteForm.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';
import 'package:ombruk/services/forms/Event/EventPostForm.dart';
import 'package:ombruk/services/forms/Event/EventUpdateForm.dart';
import 'package:ombruk/services/interfaces/IApi.dart';
import 'package:ombruk/services/interfaces/ICalendarService.dart';

class CalendarService extends ICalendarService {
  final IApi _api;
  CalendarService(this._api);

  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(
    EventGetForm form,
  ) async {
    final CustomResponse response =
        await _api.getRequest(ApiEndpoint.events, form);

    if (!response.success) {
      return response;
    }

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

  /// Returns a CustomResponse with null data
  Future<CustomResponse> createCalendarEvent(EventPostForm form) async =>
      // final String startString = DateUtils.getDateString(eventData.startDateTime);
      // final String endString = DateUtils.getDateString(eventData.endDateTime);
      // final String untilString = DateUtils.getDateString(eventData.untilDateTime);

      // final List<String> weekdaysString =
      //     eventData.weekdays.map((e) => describeEnum(e).toUpperCase()).toList();

      // String body = jsonEncode({
      //   'startDateTime': startString,
      //   'endDateTime': endString,
      //   'stationId': eventData.station.id,
      //   'partnerId': eventData.partner.id,
      //   'recurrenceRule': {
      //     'until': untilString,
      //     'days': weekdaysString,
      //     'interval': eventData.interval,
      //   },
      // });

      await _api.postRequest(ApiEndpoint.events, form);

  /// Returns a CustomResponse with null data
  Future<CustomResponse> deleteCalendarEvent(EventDeleteForm form) async =>
      _api.deleteRequest(ApiEndpoint.events, form);

  /// Returns a CustomResponse with null data
  Future<CustomResponse<CalendarEvent>> updateEvent(
      EventUpdateForm form) async {
    CustomResponse response = await _api.patchRequest(ApiEndpoint.events, form);
    if (!response.success) {
      return response;
    }
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
}
