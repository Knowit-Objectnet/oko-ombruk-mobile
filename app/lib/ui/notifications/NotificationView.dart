import 'package:flutter/material.dart';
import 'package:ombruk/ui/app/widgets/AppDrawer.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OkoAppBar(
        title: "Varsler",
        showBackButton: false,
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Varsler kommer her'),
      ),
    );
  }
}
