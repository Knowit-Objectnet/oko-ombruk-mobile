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
  final List<String> _bottomAppBarItems = [
    customIcons.list,
    customIcons.weight,
    customIcons.notification
  ];

  int _selectedIndex = 0;

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
          // The screens below are in the drawer
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
          isSelected: _selectedIndex > 2,
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
                DrawerButton(
                  icon: customIcons.partners,
                  title: 'Sam. partnere',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  isSelected: _selectedIndex == 3,
                ),
                DrawerButton(
                  icon: customIcons.map,
                  title: 'Stasjonene',
                  onTap: null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.add,
                  title: 'Søk ekstrauttak',
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => PickupDialogPartners(),
                  ),
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.addDiscrepancy,
                  title: 'Send beskjed',
                  onTap: null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.person,
                  title: 'Min side',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  isSelected: _selectedIndex == 4,
                ),
                DrawerButton(
                  icon: customIcons.settings,
                  title: 'Innstillinger',
                  onTap: null,
                  isSelected: false,
                ),
              ],
            ),
          );
        });
  }
}
