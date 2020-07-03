class WeightEvent {
  final String title;
  final String description;
  final DateTime start;
  final DateTime end;
  final double weight;

  WeightEvent(this.title, this.description, this.start, this.end, this.weight);

  factory WeightEvent.fromJson(Map<String, dynamic> json) {
    DateTime startDate;
    DateTime endDate;
    try {
      startDate = DateTime.parse(json['start']);
      endDate = DateTime.parse(json['end']);
    } catch (_) {
      throw Exception("Invalid DateTime format in WeightEvent");
      // TODO: set state errror
    }
    return WeightEvent(json['title'], json['description'], startDate, endDate,
        json['weight'].toDouble());
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'start': start,
        'end': end,
        'weight': weight
      };
}
