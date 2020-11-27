import 'package:flutter/foundation.dart';
import 'package:ombruk/models/CustomResponse.dart';

class CacheObject {
  String json;
  Set<Function> callbacks;
  Function(CustomResponse) parser;
  bool invalidated;

  CacheObject(
    this.json, {
    Set<Function> callbacks,
    @required this.parser,
    this.invalidated = false,
  }) : callbacks = callbacks ?? Set();
}
