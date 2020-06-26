import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // _authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Loading...')));
  }

  // Only for concept testing
  void _authenticate() async {
    Future.delayed(Duration(seconds: 0),
        () => Navigator.of(context).pushReplacementNamed('/login'));
  }
}
