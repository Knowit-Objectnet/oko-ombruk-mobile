import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class NoEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          CustomIcons.image(CustomIcons.calendar, size: 50.0),
          Text(
            'Ingen avtaler!',
            style: TextStyle(fontSize: 28.0, color: CustomColors.osloDarkBlue),
          ),
          Text(
            'Det er ingen hendelser opprettet for stasjonen.',
            textAlign: TextAlign.center,
            style: TextStyle(color: CustomColors.osloDarkBlue),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
