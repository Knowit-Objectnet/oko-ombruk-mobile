import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/SamPartnersComponents/PickupDialogPartners.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocProvider.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightRouter.dart';
import 'package:ombruk/globals.dart' as globals;

enum PopUpMenuOptions { myPage, logOut }

class TabsScreenPartner extends StatefulWidget {
  @override
  _TabsScreenPartnerState createState() => _TabsScreenPartnerState();
}

class _TabsScreenPartnerState extends State<TabsScreenPartner> {
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
              leading:
                  Image.asset('assets/icons/add.png', color: globals.osloWhite),
              title: Text('Søk om ekstra uttak'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context, builder: (_) => PickupDialogPartners());
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
          CalendarBlocProvider(),
          WeightRouter(),
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
            icon: Image.asset('assets/icons/vekt-ikon.png',
                height: 25, color: globals.osloWhite),
            activeIcon: Image.asset('assets/icons/vekt-ikon.png',
                height: 25, color: _selectedItemColor),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/varsel-ikon.png',
                height: 25, color: globals.osloWhite),
            activeIcon: Image.asset('assets/icons/varsel-ikon.png',
                height: 25, color: _selectedItemColor),
            title: Container(),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _selectedItemColor,
        unselectedItemColor: globals.osloWhite,
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
