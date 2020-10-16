import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/calendar/widgets/CalendarEventExpander.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class EventInfoDialog extends StatefulWidget {
  final CalendarEvent event;

  EventInfoDialog({Key key, @required this.event}) : super(key: key);

  @override
  _EventInfoDialogState createState() => _EventInfoDialogState();
}

class _EventInfoDialogState extends State<EventInfoDialog> {
  @override
  Widget build(BuildContext context) {
    CalendarEvent event = widget.event;
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: CustomColors.osloLightBlue,
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
                    icon: CustomIcons.image(CustomIcons.close),
                    onPressed: _closeDialog)
              ],
            ),
          ),
          CalendarEventExpander(event: event)
        ],
      ),
    );
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}
