import 'package:flutter/material.dart';

extension TimeOfDayComparision on TimeOfDay {
  bool operator >(TimeOfDay other) {
    return this.hour > other.hour ||
        this.hour == other.hour && this.minute > other.minute;
  }

  bool operator <(TimeOfDay other) {
    return this.hour < other.hour ||
        this.hour == other.hour && this.minute < other.minute;
  }

  bool operator <=(TimeOfDay other) {
    return this.hour == other.hour || this.hour < other.hour;
  }

  bool operator >=(TimeOfDay other) {
    return this.hour == other.hour || this.hour > other.hour;
  }
}
