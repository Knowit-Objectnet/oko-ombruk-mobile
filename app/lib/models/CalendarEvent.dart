// import 'dart:convert';

class CalendarEvent {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final double weight;

  CalendarEvent(
      this.title, this.description, this.start, this.end, this.weight);

  CalendarEvent.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        start = json['start'] is DateTime ? json['start'] : null,
        end = json['end'] is DateTime ? json['end'] : null,
        weight = json['weight'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'start': start,
        'end': end,
        'weight': weight
      };
}
