import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Pickup.dart';

class Request {
  Pickup pickup;
  Partner partner;

  Request(this.pickup, this.partner) {
    assert(pickup != null);
    assert(partner != null);
  }

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      Pickup.fromJson(json["pickup"]),
      Partner.fromJson(json["partner"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "pickup": pickup.toJson(),
        "partner": pickup.toJson(),
      };
}
