import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/partners/PartnerScreen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportScreen.dart';

enum PopUpMenuOptions { logOut }

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  String _title = 'Kalender';
  List<Widget> _widgetOptions = <Widget>[
    CalendarScreen(),
    NotificationScreen(),
    PartnerScreen(),
    WeightReportScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _title = 'Kalender';
          break;
        case 1:
          _title = 'Varsler';
          break;
        case 2:
          _title = 'Samarbeidspartnere';
          break;
        case 3:
          _title = 'Vektuttak';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          PopupMenuButton<PopUpMenuOptions>(
            key: Key('popMenu'),
            onSelected: _popUpItemSelected,
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<PopUpMenuOptions>>[
              PopupMenuItem(
                  value: PopUpMenuOptions.logOut,
                  child: Text('Logg ut'),
                  key: Key('logout')),
            ],
            icon: Icon(Icons.person_pin),
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .fixed, // Fixes an issue because the navbar cannot have more than 3 items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text('Kalender')),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text('Varsler')),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('Samarbeidspartnere')),
          BottomNavigationBarItem(
              icon: Icon(Icons.report), title: Text('Vektuttak')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _popUpItemSelected(PopUpMenuOptions option) {
    switch (option) {
      case PopUpMenuOptions.logOut:
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationLogOut());
        break;
      default:
        break;
    }
  }
}
