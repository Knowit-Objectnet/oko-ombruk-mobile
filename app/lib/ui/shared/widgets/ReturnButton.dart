import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

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
            backgroundColor: Colors.transparent,
            child: IconButton(
              icon: CustomIcons.image(CustomIcons.arrowLeft, size: 24),
              onPressed: () => Navigator.pop(context, this.returnValue),
            ),
          ),
        ],
      ),
    );
  }
}
