import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/globals.dart' as globals;

class PartnerPicker extends StatelessWidget {
  final String selectedPartner;
  final ValueChanged<String> partnerChanged;

  PartnerPicker(
      {@required this.selectedPartner, @required this.partnerChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 4.0),
            child:
                Image.asset('assets/icons/driver.png', height: 20, width: 20)),
        Container(
          // color: , // TODO
          child: DropdownButton<String>(
            value: selectedPartner,
            onChanged: partnerChanged,
            underline: Container(),
            items: globals.partners
                .map((station) => DropdownMenuItem(
                      value: station,
                      child: Text(station),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
