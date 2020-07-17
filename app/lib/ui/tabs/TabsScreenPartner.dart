import 'package:flutter/material.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/ui/tabs/SamPartnersComponents/PickupDialogPartners.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/bottomAppBarButton.dart';
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
    list.add(
      BottomAppBarButton(
          icon: customIcons.menu,
          isSelected: false,
          onPressed: _showNavigationDrawer),
    );
    list.add(Spacer());
    for (int index = 0; index < _bottomAppBarItems.length; index++) {
      list.add(
        BottomAppBarButton(
            icon: _bottomAppBarItems[index],
            isSelected: _selectedIndex == index,
            onPressed: () {
              setState(() {
                _selectedIndex = index;
              });
            }),
      );
    }
    return list;
  }

  void _showNavigationDrawer() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            color: globals.osloDarkBlue,
            child: ListView(
              children: <Widget>[
                DrawerButton(customIcons.partners, 'Sam. partnere', null),
                DrawerButton(customIcons.map, 'Stasjonene', null),
                DrawerButton(
                    customIcons.add,
                    'Søk ekstrauttak',
                    () => showDialog(
                        context: context,
                        builder: (_) => PickupDialogPartners())),
                DrawerButton(customIcons.addDiscrepancy, 'Send beskjed', null),
                DrawerButton(customIcons.person, 'Min side', null),
                DrawerButton(customIcons.close, 'Logg ut (to be removed)', () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLogOut());
                }),
                DrawerButton(customIcons.settings, 'Innstillinger', null),
              ],
            ),
          );
        });
  }
}
