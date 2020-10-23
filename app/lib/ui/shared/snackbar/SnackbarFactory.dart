import 'package:flutter/material.dart';

enum SnackBarType {
  Simple,
}

abstract class SnackBarFactory {
  static SnackBar create(SnackBarType type, Map<String, dynamic> parameters) {
    switch (type) {
      case SnackBarType.Simple:
        return SnackBar(
          content: Text(parameters["text"]),
        );
      default:
        return SnackBar(
          content: Container(),
        );
    }
  }
}
