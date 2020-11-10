import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class NoEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("yaaa");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Spacer(),
          CustomIcons.image(CustomIcons.calendar, size: 50.0),
          Text(
            'Vi er stengt!',
            style: TextStyle(fontSize: 28.0, color: CustomColors.osloDarkBlue),
          ),
          Text(
            'Vennligst velg en av dagene vi er åpne.',
            textAlign: TextAlign.center,
            style: TextStyle(color: CustomColors.osloDarkBlue),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
