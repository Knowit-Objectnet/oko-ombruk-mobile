import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/tabs/SamPartnersComponents/CalendarEventExpander.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class EventInfoDialog extends StatefulWidget {
  EventInfoDialog({Key key, @required this.event}) : super(key: key);
  final CalendarEvent event;
  @override
  _EventInfoDialogState createState() => _EventInfoDialogState();
}

class _EventInfoDialogState extends State<EventInfoDialog> {
  @override
  Widget build(BuildContext context) {
    CalendarEvent event = widget.event;
    return Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Container(
          color: customColors.osloLightBlue,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      event.partner.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                    icon: customIcons.image(customIcons.close),
                    onPressed: _closeDialog)
              ])),
      CalendarEventExpander(event: event)
    ]));
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}
