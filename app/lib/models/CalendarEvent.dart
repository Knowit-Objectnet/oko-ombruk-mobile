class CalendarEvent {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final double weight;

  CalendarEvent(
      this.title, this.description, this.start, this.end, this.weight);

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    DateTime startDate;
    DateTime endDate;
    try {
      startDate = DateTime.parse(json['start']);
      endDate = DateTime.parse('end');
    } catch (_) {
      // TODO: set state errror
    }
    return CalendarEvent(
        json['title'], json['description'], startDate, endDate, json['weight']);
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'start': start,
        'end': end,
        'weight': weight
      };
}
