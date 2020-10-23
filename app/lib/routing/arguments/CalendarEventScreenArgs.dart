import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';

class CalendarEventScreenArgs {
  final Station station;
  final Partner partner;
  CalendarEventScreenArgs(this.station, this.partner);
}
