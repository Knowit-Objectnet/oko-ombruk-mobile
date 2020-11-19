import 'package:flutter/material.dart';
import 'package:ombruk/models/Pickup.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/utils/DateUtils.dart';

class PickupContainer extends StatelessWidget {
  final Pickup pickup;
  final Widget child;
  final List<Widget> children;
  PickupContainer({
    @required this.pickup,
    this.child: const SizedBox(),
    this.children = const [const SizedBox()],
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            color: CustomColors.osloLightBlue,
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Sendt av: "),
                    Text(
                      pickup.station.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Uttak: "),
                    Text(
                      "${DateUtils.getTimeString(pickup.startDateTime)}-${DateUtils.getTimeString(pickup.endDateTime)}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateUtils.getDMYString(pickup.startDateTime),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Kategori: "),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Merknad: ${pickup.description}",
                      ),
                    ),
                  ],
                ),
                child,
              ],
            ),
          ),
          ...children
        ],
      ),
    );
  }
}
