import 'package:flutter/material.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/ui/notifications/widget/PickupContainer.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class AdminPickupContainer extends StatelessWidget {
  final Pickup pickup;
  AdminPickupContainer({@required this.pickup});
  @override
  Widget build(BuildContext context) {
    return PickupContainer(
      pickup: pickup,
      children: [
        if (pickup.requests.isEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              color: CustomColors.osloLightBlue,
              child: Text("Ingen forespørsler"),
            ),
          ),
        ...pickup.requests
            .map(
              (req) => Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: CustomColors.osloLightBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        req.partner.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.45,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  req.pickup.chosenPartner == null
                                      ? "Avventer svar"
                                      : req.pickup.chosenPartner.id ==
                                              req.partner.id
                                          ? "Godkjent"
                                          : "Avvist",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              color: req.pickup.chosenPartner == null
                                  ? CustomColors.osloLightBlue
                                  : req.pickup.chosenPartner.id ==
                                          req.partner.id
                                      ? CustomColors.osloGreen
                                      : CustomColors.osloRed,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
