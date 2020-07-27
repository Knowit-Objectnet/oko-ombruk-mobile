import 'package:flutter/material.dart';

import 'package:ombruk/ui/tabs/SamPartnersComponents/MyPagePartners.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocProvider.dart';

import 'package:ombruk/ui/tabs/SamPartnersComponents/PickupDialogPartners.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/BottomAppBarButton.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/partners/PartnerScreen.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportScreen.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
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
          WeightReportScreen(),
          NotificationScreen(),
          SafeArea(child: PartnerScreen()),
          SafeArea(child: MyPagePartners()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: customColors.osloDarkBlue,
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
            color: customColors.osloDarkBlue,
            child: ListView(
              children: <Widget>[
                DrawerButton(customIcons.partners, 'Sam. partnere', () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                }),
                DrawerButton(customIcons.map, 'Stasjonene', null),
                DrawerButton(
                    customIcons.add,
                    'Søk ekstrauttak',
                    () => showDialog(
                        context: context,
                        builder: (_) => PickupDialogPartners())),
                DrawerButton(customIcons.addDiscrepancy, 'Send beskjed', null),
                DrawerButton(customIcons.person, 'Min side', () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                }),
                DrawerButton(customIcons.settings, 'Innstillinger', null),
              ],
            ),
          );
        });
  }
}
