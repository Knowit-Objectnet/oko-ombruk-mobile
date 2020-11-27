import 'dart:convert';

import 'package:ombruk/models/CustomResponse.dart';

mixin ParseResponse<T> {
  CustomResponse<List<T>> parseList<T>(
      CustomResponse response, T Function(dynamic) parser) {
    try {
      List<T> objects = List<dynamic>.from(jsonDecode(response.data))
          .map((event) => parser(event))
          .toList();
      return CustomResponse(
        success: true,
        statusCode: response.statusCode,
        data: objects,
      );
    } catch (error) {
      return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: "$error ${response.data}");
    }
  }

  CustomResponse<T> parseObject<T>(
      CustomResponse response, T Function(dynamic) parser) {
    try {
      T object = parser(response.data);
      return CustomResponse(
          success: true, statusCode: response.statusCode, data: object);
    } catch (e) {
      return CustomResponse(
          success: false,
          statusCode: response.statusCode,
          data: null,
          message: e.toString());
    }
  }
}
