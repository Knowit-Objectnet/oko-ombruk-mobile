import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class PickupDialogPartners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: customColors.osloDarkBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Søk om ekstra uttak',
                        style: TextStyle(
                            color: customColors.osloWhite, fontSize: 16.0))),
                IconButton(
                    icon: customIcons.image(customIcons.close,
                        size: 25, color: customColors.osloWhite),
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
              color: customColors.osloLightGreen,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    'Søk om midlertidig kontrakt',
                    textAlign: TextAlign.center,
                  )),
                  IconButton(
                    icon: customIcons.image(customIcons.arrowRight, size: 25),
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
