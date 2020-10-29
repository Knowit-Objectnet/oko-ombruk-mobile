import 'package:flutter/material.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OkoAppBar(
        title: "Varsler",
      ),
      body: Center(
        child: Text('Varsler kommer her'),
      ),
    );
  }
}
