import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class PickupDialogPartners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: globals.osloDarkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Søk om ekstra uttak',
                        style: TextStyle(
                            color: globals.osloWhite, fontSize: 16.0))),
                IconButton(
                    icon: Image.asset(
                      'assets/icons/lukk.png',
                      height: 25,
                      width: 25,
                      color: globals.osloWhite,
                    ),
                    onPressed: () => Navigator.of(context).pop()),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  'Har organisasjonen behov for å hente ekstra må det søkes om en midlertidig kontrakt. Klikk på knappen under for å bli tatt til skjemaet')),
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: FlatButton(
              color: globals.osloLightGreen,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Søk om midlertidig kontrakt',
                    textAlign: TextAlign.center,
                  )),
                  IconButton(
                    icon: Image.asset('assets/icons/arrow-right.png',
                        height: 25, width: 25),
                    onPressed: _submitPickup,
                  )
                ],
              ),
              onPressed: () => null,
            ),
          ),
        ],
      ),
    );
  }

  void _submitPickup() {
    // TODO - open URL or something
    return;
  }
}
