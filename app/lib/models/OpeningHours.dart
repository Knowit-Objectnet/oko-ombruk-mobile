import 'package:flutter/material.dart';

class OpeningHours {
  TimeOfDay opensAt;
  TimeOfDay closesAt;
  bool isClosed;
  OpeningHours(this.opensAt, this.closesAt, {this.isClosed = false});
}
