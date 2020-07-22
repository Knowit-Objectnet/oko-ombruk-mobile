import 'package:flutter/material.dart';
import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/globals.dart' as globals;

class CalendarEventExpander extends StatefulWidget {
  CalendarEventExpander({Key key, @required this.event}) : super(key: key);

  final CalendarEvent event;
  @override
  _CalendarEventExpanderState createState() => _CalendarEventExpanderState();
}

class _CalendarEventExpanderState extends State<CalendarEventExpander> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CalendarEvent event = widget.event;
    return Padding(
        padding: EdgeInsets.all(6),
        child: IntrinsicHeight(
            child: Container(
          color: customColors.osloWhite,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _dateTextDropDown(event.startDateTime),
                      _timeTextDropDown(event.startDateTime, event.endDateTime),
                      Row(
                        children: <Widget>[
                          customIcons.image(customIcons.map, size: 25),
                          VerticalDivider(thickness: 100),
                          Text(event.station.name.toString(),
                              style: TextStyle(fontSize: 18.0))
                        ],
                      )
                    ]),
                IntrinsicHeight(
                    child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Text('Avlys uttak',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: customColors.osloBlack,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      )),
                  trailing: CircleAvatar(
                    backgroundColor: customColors.osloRed,
                    radius: 20.0,
                    child: isExpanded
                        ? customIcons.image(customIcons.arrowUpThin)
                        : customIcons.image(customIcons.arrowDownThin),
                  ),
                  onExpansionChanged: (bool newState) {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Radio(
                            activeColor: customColors.osloBlack,
                            value: false,
                            onChanged: null,
                          ),
                          Text('Engangstilfelle'),
                          Radio(
                            activeColor: customColors.osloBlack,
                            value: true,
                            onChanged: null,
                          ),
                          Text('Periode')
                        ]),
                    FlatButton(
                        onPressed: () {
                          null;
                        },
                        color: customColors.osloGreen,
                        child: Text('Bekreft'))
                  ],
                ))
              ],
            ),
          ),
        )));
  }

  Widget _timeTextDropDown(DateTime start, DateTime end) {
    return Row(
      children: <Widget>[
        customIcons.image(customIcons.clock, size: 25),
        VerticalDivider(thickness: 100),
        Text(
            start.hour.toString().padLeft(2, '0') +
                ':' +
                start.minute.toString().padLeft(2, '0') +
                ' til ' +
                end.hour.toString().padLeft(2, '0') +
                ':' +
                end.minute.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 18.0))
      ],
    );
  }

  Widget _dateTextDropDown(DateTime dateTime) {
    return Row(
      children: <Widget>[
        customIcons.image(customIcons.calendar, size: 25),
        VerticalDivider(thickness: 100),
        Text(
            globals.monthsShort[dateTime.month] +
                ' ' +
                dateTime.day.toString() +
                ', ' +
                dateTime.year.toString(),
            style: TextStyle(fontSize: 18.0))
      ],
    );
  }
}
