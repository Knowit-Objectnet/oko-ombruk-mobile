import 'package:flutter/material.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/ui/notifications/widget/PickupContainer.dart';

class PartnerPickupContainer extends StatelessWidget {
  final Pickup pickup;
  final Widget button;
  PartnerPickupContainer({@required this.pickup, @required this.button});
  @override
  Widget build(BuildContext context) {
    return PickupContainer(
      pickup: pickup,
      child: Align(
        alignment: Alignment.centerRight,
        child: button,
      ),
    );
  }
}
