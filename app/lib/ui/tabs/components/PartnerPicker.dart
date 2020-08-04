import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/Partner.dart';
import 'package:ombruk/businessLogic/PartnerViewModel.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class PartnerPicker extends StatelessWidget {
  final Partner selectedPartner;
  final ValueChanged<Partner> partnerChanged;
  final Color backgroundColor;

  PartnerPicker({
    @required this.selectedPartner,
    @required this.partnerChanged,
    this.backgroundColor = customColors.osloWhite,
  }) : assert(partnerChanged != null);

  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerViewModel>(
      builder: (context, PartnerViewModel partnerViewModel, child) {
        return Container(
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: customIcons.image(customIcons.driver)),
              Container(
                child: DropdownButton<Partner>(
                  value: selectedPartner,
                  hint: Text('Velg partner'),
                  onChanged: partnerChanged,
                  underline: Container(),
                  items: partnerViewModel.partners
                      .map((partner) => DropdownMenuItem(
                            value: partner,
                            child: Text(partner.name ?? ''),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
