import 'package:flutter/material.dart';
import 'package:ombruk/models/Request.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class AdminRequestRow extends StatelessWidget {
  final Request request;
  AdminRequestRow({@required this.request}) : assert(request != null);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        color: CustomColors.osloLightBlue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              request.partner.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 0.45,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        request.pickup.chosenPartner == null
                            ? "Avventer svar"
                            : request.pickup.chosenPartner.id ==
                                    request.partner.id
                                ? "Godkjent"
                                : "Avvist",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    color: request.pickup.chosenPartner == null
                        ? CustomColors.osloLightBlue
                        : request.pickup.chosenPartner.id == request.partner.id
                            ? CustomColors.osloGreen
                            : CustomColors.osloRed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
