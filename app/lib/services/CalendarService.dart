import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ombruk/businessLogic/UserViewModel.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/models/CustomResponse.dart';
import 'package:ombruk/services/serviceLocator.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventData.dart';

import 'package:ombruk/globals.dart' as globals;

class CalendarService {
  UserViewModel _userViewModel = serviceLocator<UserViewModel>();

  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  void _updateTokenInHeader() {
    final String token = 'Bearer ' + (_userViewModel?.accessToken ?? '');
    if (_headers.containsKey('Authorization')) {
      _headers.update('Authorization', (value) => token);
    } else {
      _headers.putIfAbsent('Authorization', () => token);
    }
  }

  /// Returns a list of CalendarEvents on sucecss
  Future<CustomResponse<List<CalendarEvent>>> fetchEvents(
      {int stationID, int partnerID}) async {
    // TODO: Add time parameter to filter on time
    Map<String, String> parameters = {};
    if (stationID != null) {
      parameters.putIfAbsent('station-id', () => stationID.toString());
    }
    if (partnerID != null) {
      parameters.putIfAbsent('partner-id', () => partnerID.toString());
    }

    Uri uri = Uri.https(
        globals.baseUrlStripped, '${globals.requiredPath}/events', parameters);

    final Response response = await get(uri, headers: _headers);

    if (response.statusCode != 200) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: response.body,
      );
    }

    List<CalendarEvent> events;
    try {
      final List<dynamic> parsed = jsonDecode(response.body);
      events = parsed.map((e) => CalendarEvent.fromJson(e)).toList();
    } catch (e) {
      return CustomResponse(
        success: false,
        statusCode: response.statusCode,
        data: null,
        message: e.toString() + ' ' + response.body,
      );
    }

    return CustomResponse(
      success: true,
      statusCode: response.statusCode,
      data: events,
      message: null,
    );
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse> createCalendarEvent(
      CreateCalendarEventData eventData) async {
    final String startString = globals.getDateString(eventData.startDateTime);
    final String endString = globals.getDateString(eventData.endDateTime);
    final String untilString = globals.getDateString(eventData.untilDateTime);

    final List<String> weekdaysString =
        eventData.weekdays.map((e) => describeEnum(e).toUpperCase()).toList();

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/events');

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

    Response response = await post(uri, headers: _headers, body: body);

    // REG authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await post(uri, headers: _headers, body: body);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
        return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
        );
      }
    }

    return CustomResponse(
      success: response.statusCode == 200,
      statusCode: response.statusCode,
      data: null,
      message: response.body,
    );
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

    _updateTokenInHeader();
    Uri uri = Uri.https(globals.baseUrlStripped,
        '${globals.requiredPath}/events', queryParameters);

    Response response = await delete(uri, headers: _headers);

    // All roles authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await delete(uri, headers: _headers);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
      }
    }

    return CustomResponse(
      success: response.statusCode == 200,
      statusCode: response.statusCode,
      data: null,
    );
  }

  /// Returns a CustomResponse with null data
  Future<CustomResponse<bool>> updateEvent(
      int id, DateTime date, TimeOfDay startTime, TimeOfDay endTime) async {
    DateTime startDateTime = DateTime(
        date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    final String startDateTimeString = globals.getDateString(startDateTime);
    final String endDateTimeString = globals.getDateString(endDateTime);

    _updateTokenInHeader();
    Uri uri =
        Uri.https(globals.baseUrlStripped, '${globals.requiredPath}/events');

    String body = jsonEncode({
      'id': id,
      'startDateTime': startDateTimeString,
      'endDateTime': endDateTimeString,
    });

    Response response = await patch(uri, headers: _headers, body: body);

    // All roles authorization
    if (response.statusCode == 401) {
      final bool gotNewTokens = await _userViewModel.requestRefreshToken();
      if (gotNewTokens) {
        _updateTokenInHeader();
        response = await patch(uri, headers: _headers, body: body);
      } else {
        // Should maybe force a re-login here
        // await _userViewModel.requestLogOut();
      }
    }

    return CustomResponse(
      success: response.statusCode == 200,
      statusCode: response.statusCode,
      data: null,
    );
  }
}
