import 'package:meta/meta.dart';

class CustomResponse {
  final bool success;
  final int statusCode;
  final dynamic data;
  final String message;

  CustomResponse({
    @required this.success,
    @required this.statusCode,
    @required this.data,
    this.message,
  });
}
