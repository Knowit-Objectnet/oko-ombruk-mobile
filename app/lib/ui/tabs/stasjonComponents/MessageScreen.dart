import 'package:flutter/material.dart';
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/globals.dart' as globals;

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Hva gjelder beskjeden?',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          _stationButton('På stasjonen', customIcons.arrowRight, () => null),
          _stationButton(
              'Sam.partner/hendelse', customIcons.arrowRight, () => null),
          _stationButton('Annet', customIcons.arrowRight, () => null),
        ],
      ),
    );
  }

  Widget _stationButton(String title, String icon, Function onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        color: globals.osloYellow,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              'assets/icons/$icon',
              height: 25,
              width: 25,
            ),
          ],
        ),
      ),
    );
  }
}
