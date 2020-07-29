import 'package:flutter/material.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;

class NewPartneScreen extends StatefulWidget {
  @override
  _NewPartneScreenState createState() => _NewPartneScreenState();
}

class _NewPartneScreenState extends State<NewPartneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColors.osloWhite,
        leading: IconButton(
          icon: customIcons.image(customIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Legg til ny stasjon'),
      ),
      backgroundColor: customColors.osloLightBeige,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        children: <Widget>[
          RaisedButton(
            onPressed: () => null,
            color: customColors.osloGreen,
            child: Text('Legg til stasjon'),
          )
        ],
      ),
    );
  }
}
