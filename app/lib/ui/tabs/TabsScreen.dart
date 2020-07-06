import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/partners/PartnerScreen.dart';
import 'package:ombruk/ui/tabs/something/SomethingScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  Color selected = Color(0xFF6FE9FF);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2A2859),
        title: const Text('Fancy titel'),
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
            icon: Image.asset('assets/icons/person-ikon.png', color: Colors.white),
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2A2859),
        type: BottomNavigationBarType
            .fixed, // Fixes an issue because the navbar cannot have more than 3 items
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/listeikon-ny.png', height: 25, color: Colors.white), activeIcon: Image.asset('assets/icons/listeikon-ny.png', height: 25, color: selected), title: Text('Kalender')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/varsel-ikon.png', height: 25, color: Colors.white), activeIcon: Image.asset('assets/icons/varsel-ikon.png', height: 25, color: selected), title: Text('Varsler')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/sampartnere.png', height: 25, color: Colors.white), activeIcon: Image.asset('assets/icons/sampartnere.png', height: 25, color: selected), title: Text('Samarbeidspartnere')),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/vekt-ikon.png', height: 25, color: Colors.white), activeIcon: Image.asset('assets/icons/vekt-ikon.png', height: 25, color: selected), title: Text('Something')),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: selected,
        unselectedItemColor: Colors.white,
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
