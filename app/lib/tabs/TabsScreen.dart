import 'package:flutter/material.dart';
import 'package:ombruk/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/tabs/partners/PartnerScreen.dart';
import 'package:ombruk/tabs/something/SomethingScreen.dart';

enum PopUpMenuOptions { logOut }

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    CalendarScreen(),
    NotificationScreen(),
    PartnerScreen(),
    SomethingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fancy titel'),
        actions: <Widget>[
          PopupMenuButton<PopUpMenuOptions>(
            onSelected: _popUpItemSelected,
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<PopUpMenuOptions>>[
              PopupMenuItem(
                  value: PopUpMenuOptions.logOut, child: Text('Logg ut')),
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
              icon: Icon(Icons.error_outline), title: Text('Something')),
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
        Navigator.of(context).pushReplacementNamed('/login');
        break;
      default:
        break;
    }
  }
}
