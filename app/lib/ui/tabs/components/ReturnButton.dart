import 'package:flutter/material.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;

/// A leftmost return button which pops the current context
class ReturnButton extends StatelessWidget {
  final dynamic returnValue;

  ReturnButton({this.returnValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: customColors.osloBlue,
            child: IconButton(
              icon: customIcons.image(customIcons.arrowLeft),
              onPressed: () => Navigator.pop(context, this.returnValue),
            ),
          ),
        ],
      ),
    );
  }
}
