import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventScreen.dart';
import 'package:ombruk/ui/tabs/components/PartnerPicker.dart';
import 'package:ombruk/ui/tabs/components/ReturnButton.dart';
import 'package:ombruk/ui/tabs/components/StationPicker.dart';
import 'package:ombruk/ui/ui.helper.dart';

class CreateOccurrenceScreen extends StatefulWidget {
  @override
  _CreateOccurrenceScreenState createState() => _CreateOccurrenceScreenState();
}

class _CreateOccurrenceScreenState extends State<CreateOccurrenceScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Partner _selectedPartner;
  Station _selectedStation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        backgroundColor: customColors.osloLightBeige,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            ReturnButton(returnValue: false),
            Text(
              'Opprett hendelse',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            _subtitle('Samarbeidspartner'),
            PartnerPicker(
              selectedPartner: _selectedPartner,
              partnerChanged: (value) {
                setState(() {
                  _selectedPartner = value;
                });
              },
            ),
            _subtitle('Stasjon(er)'),
            StationPicker(
              selectedStation: _selectedStation,
              stationChanged: (value) {
                setState(() {
                  _selectedStation = value;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: _nextButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subtitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
      child: Text(
        text ?? '',
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _nextButton() {
    return GestureDetector(
      onTap: () async {
        if (_selectedPartner == null) {
          uiHelper.showSnackbarUnknownScaffold(
              _key.currentState, 'Vennligst velg en partner');
          return;
        }
        if (_selectedStation == null) {
          uiHelper.showSnackbarUnknownScaffold(
              _key.currentState, 'Vennligst velg en stasjon');
          return;
        }
        final occurrenceAdded = await Navigator.push(
          context,
          MaterialPageRoute<bool>(
            builder: (_) => CreateCalendarEventScreen(
              partner: _selectedPartner,
              station: _selectedStation,
            ),
          ),
        );
        if (occurrenceAdded != null && occurrenceAdded) {
          Navigator.pop(context, true);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        color: customColors.osloBlue,
        child: Row(
          children: <Widget>[
            Spacer(),
            Text(
              'Neste',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Spacer(),
            customIcons.image(customIcons.arrowRight),
          ],
        ),
      ),
    );
  }
}
