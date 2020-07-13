import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarRouter.dart';
import 'package:ombruk/ui/tabs/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightRouter.dart';
import 'package:ombruk/globals.dart' as globals;

enum PopUpMenuOptions { myPage, logOut }

class TabsScreenStasjon extends StatefulWidget {
  @override
  _TabsScreenStasjonState createState() => _TabsScreenStasjonState();
}

class _TabsScreenStasjonState extends State<TabsScreenStasjon> {
  int _selectedIndex = 0;
  String _title = 'Kalender';
  Color _selectedItemColor = globals.osloLightBlue;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _title = 'Kalender';
          break;
        case 1:
          _title = 'Dine vektuttak';
          break;
        case 2:
          _title = 'Varsler';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: Color(0xFF2A2859),
        actions: <Widget>[
          PopupMenuButton<PopUpMenuOptions>(
            key: Key('popMenu'),
            onSelected: _popUpItemSelected,
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<PopUpMenuOptions>>[
              const PopupMenuItem(
                value: PopUpMenuOptions.myPage,
                child: Text('Min side'),
                key: Key('mypage'),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: PopUpMenuOptions.logOut,
                child: Text('Logg ut'),
                key: Key('logout'),
              ),
            ],
            icon: Image.asset('assets/icons/person-ikon.png',
                color: Colors.white),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Sam. partnere'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.directions_run),
              title: Text('Gjenvinningsstasjoner'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Send beskjed'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Søk om ekstra uttak'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context, builder: (_) => ExtraHentingDialog());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Innstillinger'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        // IndexStack keeps the screen states alive between tab changes
        index: _selectedIndex,
        children: <Widget>[
          CalendarRouter(),
          WeightRouter(),
          NotificationScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2A2859),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/listeikon-ny.png',
                height: 25, color: Colors.white),
            activeIcon: Image.asset('assets/icons/listeikon-ny.png',
                height: 25, color: _selectedItemColor),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/klokke-ikon.png',
                height: 25, color: Colors.white),
            activeIcon: Image.asset('assets/icons/vekt-ikon.png',
                height: 25, color: _selectedItemColor),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/varsel-ikon.png',
                height: 25, color: Colors.white),
            activeIcon: Image.asset('assets/icons/varsel-ikon.png',
                height: 25, color: _selectedItemColor),
            title: Container(),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _popUpItemSelected(PopUpMenuOptions option) {
    switch (option) {
      case PopUpMenuOptions.myPage:
        // TODO
        break;
      case PopUpMenuOptions.logOut:
        BlocProvider.of<AuthenticationBloc>(context)
            .add(AuthenticationLogOut());
        break;
      default:
        break;
    }
  }
}
