class EventGetForm {
  int stationId;
  int partnerId;
  EventGetForm({stationId, partnerId});

  EventGetForm create(int stationId, int partnerId) {
    var tmp = EventGetForm(stationId: stationId, partnerId: partnerId);
    bool validated = validate(tmp);
    if (validated) {
      return tmp;
    } else {
      //Rather return something else.
      throw Exception();
    }
  }

  bool validate(EventGetForm form) {
    return true;
  }

  Map<String, dynamic> _toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'phone': phone,
        'email': email,
      };

  Map<String, dynamic> => _toJson() => {
    if(stationId != null) 'stationId': stationId,
    if(partnerId != null) 'partnerId': partnerId,
  };
}
