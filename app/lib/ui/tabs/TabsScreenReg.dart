import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';
import 'package:ombruk/DataProvider/CalendarApiClient.dart';
import 'package:ombruk/repositories/CalendarRepository.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventScreen.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';
import 'package:ombruk/ui/tabs/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';

import 'package:ombruk/globals.dart' as globals;

enum PopUpMenuOptions { myPage, logOut }

class TabsScreenReg extends StatefulWidget {
  @override
  _TabsScreenRegState createState() => _TabsScreenRegState();
}

class _TabsScreenRegState extends State<TabsScreenReg> {
  int _selectedIndex = 0;
  String _title = 'Kalender';
  Color _selectedItemColor = globals.osloLightBlue;

  final CalendarRepository calendarRepository =
      CalendarRepository(apiClient: CalendarApiClient());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _title = 'Kalender';
          break;
        case 1:
          _title = 'Ekstra henting';
          break;
        case 2:
          _title = 'Statistikk';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calendar Bloc needs to be accessed in both Calendar screen and createCalendarEvent screen
    return BlocProvider(
      create: (context) => CalendarBloc(calendarRepository: calendarRepository)
        ..add(CalendarInitialEventsRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_title),
          backgroundColor: globals.osloDarkBlue,
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
              icon: Image.asset('assets/icons/person.png',
                  color: globals.osloWhite),
            )
          ],
        ),
        drawer: Drawer(
            child: Container(
          color: globals.osloDarkBlue,
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Image.asset('assets/icons/sampartnere.png',
                    color: globals.osloWhite),
                title: Text('Sam. partnere'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('assets/icons/kart.png',
                    color: globals.osloWhite),
                title: Text('Gjenvinningsstasjoner'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('assets/icons/mail.png',
                    color: globals.osloWhite),
                title: Text('Send beskjed'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Image.asset('assets/icons/add.png',
                    color: globals.osloWhite),
                title: Text('Søk om ekstra uttak'),
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context, builder: (_) => ExtraHentingDialog());
                },
              ),
              ListTile(
                leading: Image.asset('assets/icons/innstillinger.png',
                    color: globals.osloWhite),
                title: Text('Innstillinger'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )),
        body: IndexedStack(
          // IndexStack keeps the screen states alive between tab changes
          index: _selectedIndex,
          children: <Widget>[
            CalendarBlocBuilder(),
            CreateCalendarEventScreen(),
            NotificationScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: globals.osloDarkBlue,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/listeikon.png',
                  height: 25, color: globals.osloWhite),
              activeIcon: Image.asset('assets/icons/listeikon.png',
                  height: 25, color: _selectedItemColor),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/kalender.png',
                  height: 25, color: globals.osloWhite),
              activeIcon: Image.asset('assets/icons/kalender.png',
                  height: 25, color: _selectedItemColor),
              title: Container(),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/icons/statistikk.png',
                  height: 25, color: globals.osloWhite),
              activeIcon: Image.asset('assets/icons/statistikk.png',
                  height: 25, color: _selectedItemColor),
              title: Container(),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: _selectedItemColor,
          unselectedItemColor: globals.osloWhite,
          onTap: _onItemTapped,
        ),
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
