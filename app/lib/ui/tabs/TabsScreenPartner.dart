import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/SamPartnersComponents/PickupDialogPartners.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocProvider.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightRouter.dart';

import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class TabsScreenPartner extends StatefulWidget {
  @override
  _TabsScreenPartnerState createState() => _TabsScreenPartnerState();
}

class _TabsScreenPartnerState extends State<TabsScreenPartner> {
  int _selectedIndex = 0;
  List<String> _bottomAppBarItems = [
    customIcons.list,
    customIcons.weight,
    customIcons.notification
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // IndexStack keeps the screen states alive between tab changes
        index: _selectedIndex,
        children: <Widget>[
          SafeArea(child: CalendarBlocProvider()),
          WeightRouter(),
          NotificationScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: globals.osloDarkBlue,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _bottomAppBarChildren(),
        ),
      ),
    );
  }

  List<Widget> _bottomAppBarChildren() {
    List<Widget> list = [];
    list.add(IconButton(
      icon: _imageIcon(fileName: customIcons.menu, isSelected: false),
      onPressed: _showNavigationDrawer,
    ));
    list.add(Spacer());
    for (int index = 0; index < _bottomAppBarItems.length; index++) {
      list.add(IconButton(
        icon: _imageIcon(
            fileName: _bottomAppBarItems[index],
            isSelected: _selectedIndex == index),
        onPressed: () => _onItemTapped(index),
      ));
    }
    return list;
  }

  Widget _imageIcon({@required String fileName, @required bool isSelected}) {
    return Image.asset(
      'assets/icons/$fileName',
      height: 25,
      width: 25,
      color: isSelected ? globals.osloLightBlue : globals.osloWhite,
    );
  }

  void _showNavigationDrawer() {
    ListTile customListTile(
        String iconName, String title, Function onTapFunction) {
      return ListTile(
        leading: Image.asset(
          'assets/icons/$iconName',
          color: globals.osloWhite,
          height: 28,
          width: 28,
        ),
        title: Text(title, style: TextStyle(color: globals.osloWhite)),
        onTap: () {
          Navigator.pop(context);
          onTapFunction();
        },
      );
    }

    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: globals.osloDarkBlue,
            child: ListView(
              children: <Widget>[
                customListTile(customIcons.partners, 'Sam. partnere', null),
                customListTile(customIcons.map, 'Stasjonene', null),
                customListTile(
                    customIcons.add,
                    'Søk ekstrauttak',
                    () => showDialog(
                        context: context,
                        builder: (_) => PickupDialogPartners())),
                customListTile(
                    customIcons.addDiscrepancy, 'Send beskjed', null),
                customListTile(customIcons.person, 'Min side', null),
                customListTile(customIcons.close, 'Logg ut', () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLogOut());
                }),
                customListTile(customIcons.settings, 'Innstillinger', null),
              ],
            ),
          );
        });
  }
}
