import 'package:flutter/material.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/ui/notifications/widget/PickupContainer.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class StationPickupContainer extends StatelessWidget {
  final Pickup pickup;
  final Function(Request) onApproveRequest;
  StationPickupContainer({
    @required this.pickup,
    @required this.onApproveRequest,
  });

  List<Widget> _children(Pickup pickup) {
    if (pickup.chosenPartner != null) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            color: CustomColors.osloLightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pickup.chosenPartner.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Godkjent",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        )
      ];
    } else if (pickup.requests.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 3.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            width: double.infinity,
            color: CustomColors.osloLightBlue,
            child: Text("Ingen forespørsler"),
          ),
        )
      ];
    } else {
      return pickup.requests
          .map(
            (req) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                color: CustomColors.osloLightBlue,
                child: Row(
                  children: [
                    Text(req.partner.name),
                    Spacer(),
                    FlatButton(
                      onPressed: () => null,
                      child: Row(
                        children: [
                          CustomIcons.image(CustomIcons.close),
                          Text("Avvis",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    RawMaterialButton(
                      elevation: 0,
                      onPressed: () => onApproveRequest(req),
                      fillColor: CustomColors.osloGreen,
                      child: Text("Godkjenn",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      constraints: BoxConstraints(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickupContainer(
      pickup: pickup,
      children: _children(pickup),
    );
  }
}
