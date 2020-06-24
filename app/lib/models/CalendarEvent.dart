// import 'dart:convert';

class CalendarEvent {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;

  CalendarEvent(this.title, this.description, this.start, this.end);

  CalendarEvent.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        start = json['start'] is DateTime ? json['start'] : null,
        end = json['end'] is DateTime ? json['end'] : null;

  Map<String, dynamic> toJson() =>
      {'title': title, 'description': description, 'start': start, 'end': end};
}
