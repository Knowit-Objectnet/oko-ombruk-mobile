import 'package:flutter/widgets.dart';

abstract class INavigatorService {

  Future<dynamic> navigateTo(String key);

  bool goBack();

}