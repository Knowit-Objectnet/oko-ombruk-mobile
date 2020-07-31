import 'package:meta/meta.dart';

class CustomResponse<T> {
  final bool success;
  final int statusCode;
  final T data;
  final String message;

  CustomResponse({
    @required this.success,
    @required this.statusCode,
    @required this.data,
    this.message,
  });

  @override
  String toString() {
    return toJson().toString();
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'data': data,
        'message': message
      };
}
