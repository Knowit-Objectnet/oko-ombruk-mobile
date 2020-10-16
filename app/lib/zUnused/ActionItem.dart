///
/// ActionItem
/// Action buttons in the TitleBar
///

import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class ActionItem extends StatefulWidget {
  // Action item key for reference on callback
  final Key key = GlobalKey<_ActionItemState>();
  final Icon icon;
  final callback;

  ActionItem({this.icon, this.callback});

  @override
  State<StatefulWidget> createState() =>
      _ActionItemState(icon: icon, callback: callback, key: key);
}

class _ActionItemState extends State<ActionItem> {
  Icon icon;
  var callback;
  Key key;

  _ActionItemState({this.icon, this.callback, this.key});

  // Callback handler. Calls function with key
  void handler() {
    return this.callback(key);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 10),
        child: CircleAvatar(
            backgroundColor: CustomColors.osloGreen,
            child: IconButton(
              color: Colors.black,
              icon: this.icon,
              onPressed: handler,
            )));
  }

  void setIcon(Icon iconn) {
    setState(() {
      this.icon = iconn;
    });
  }
}
