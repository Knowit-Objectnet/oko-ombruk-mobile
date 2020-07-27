import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class NameBox extends StatelessWidget {
  final String name;
  final bool isReported;

  NameBox({@required this.name, @required this.isReported});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          color: isReported ? customColors.osloGreen : customColors.osloRed,
          child: Center(
            // child: Text(calendarEvent.partner?.name ?? ''),
            child: (Text(name ?? '')),
          ),
        ),
      ),
    );
  }
}
