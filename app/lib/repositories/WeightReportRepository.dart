import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'dart:convert';

import 'package:ombruk/DataProvider/WeightReportClient.dart';
import 'package:ombruk/models/WeightEvent.dart';

class WeightReportRepository {
  final WeightReportClient apiClient;

  // TODO: Save weightEvents here instead of passing it down

  WeightReportRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List<WeightEvent>> getWeightEvents() async {
    Response response = await apiClient.fetchWeightEvents();
    final List<dynamic> parsed = jsonDecode(response.body);
    return parsed.map((e) => WeightEvent.fromJson(e)).toList();
  }
}
