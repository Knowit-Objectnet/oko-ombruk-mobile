import 'package:flutter/material.dart';
import 'package:ombruk/ui/tabs/stasjonComponents/MessageScreen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text('Send beskjed kommer her'),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen()),
        ),
      ),
    );
  }
}
