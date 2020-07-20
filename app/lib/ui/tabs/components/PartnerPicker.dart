import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customColors.dart' as customColors;

class PartnerPicker extends StatelessWidget {
  final String selectedPartner;
  final ValueChanged<String> partnerChanged;
  final Color backgroundColor;

  PartnerPicker({
    @required this.selectedPartner,
    @required this.partnerChanged,
    this.backgroundColor = customColors.osloWhite,
  }) : assert(partnerChanged != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Image.asset('assets/icons/driver.png',
                  height: 20, width: 20)),
          Container(
            child: DropdownButton<String>(
              value: selectedPartner,
              hint: Text('Velg partner'),
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
      ),
    );
  }
}
