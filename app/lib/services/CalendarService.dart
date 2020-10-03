import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/const/ApiEndpoint.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/Api.dart';
import 'package:ombruk/services/forms/Event/EventGetForm.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

import 'package:ombruk/globals.dart' as globals;

class CalendarService {
  Api _api = Api();

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
  Future<CustomResponse> createCalendarEvent(
      CreateCalendarEventData eventData) async {
    final String startString = globals.getDateString(eventData.startDateTime);
    final String endString = globals.getDateString(eventData.endDateTime);
    final String untilString = globals.getDateString(eventData.untilDateTime);

    final List<String> weekdaysString =
        eventData.weekdays.map((e) => describeEnum(e).toUpperCase()).toList();

    String body = jsonEncode({
      'startDateTime': startString,
      'endDateTime': endString,
      'stationId': eventData.station.id,
      'partnerId': eventData.partner.id,
      'recurrenceRule': {
        'until': untilString,
        'days': weekdaysString,
        'interval': eventData.interval,
      },
    });

    return await _api.postRequest(ApiEndpoint.events, null);
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse> deleteCalendarEvent(int id, DateTime startDate,
      DateTime endDate, dynamic recurrenceRuleID) async {
    final String startString = globals.getDateString(startDate);
    final String endString = globals.getDateString(endDate);
    var queryParameters;

    if (id == null) {
      queryParameters = {
        'recurrenceRuleId': recurrenceRuleID.toString(),
        'fromDate': startString,
        'toDate': endString
      };
    } else {
      queryParameters = {'eventId': id.toString()};
    }

    return _api.deleteRequest(ApiEndpoint.events, queryParameters);
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse<String>> updateEvent(
    int id,
    DateTime date,
    TimeOfDay startTime,
    TimeOfDay endTime,
  ) async {
    DateTime startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    final String startDateTimeString = globals.getDateString(startDateTime);
    final String endDateTimeString = globals.getDateString(endDateTime);

    String body = jsonEncode({
      'id': id,
      'startDateTime': startDateTimeString,
      'endDateTime': endDateTimeString,
    });

    return await _api.patchRequest(ApiEndpoint.events, body);
  }
}
