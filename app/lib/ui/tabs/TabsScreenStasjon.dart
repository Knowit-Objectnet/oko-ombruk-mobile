import 'package:flutter/material.dart';

import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/BottomAppBarButton.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarScreen.dart';
import 'package:ombruk/ui/tabs/myPage/MyPage.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/stasjonComponents/AddExtraPickupScreen.dart';
import 'package:ombruk/ui/tabs/stasjonComponents/MessageScreen.dart';
import 'package:ombruk/ui/tabs/weightreport/WeightReportScreen.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class TabsScreenStasjon extends StatefulWidget {
  @override
  _TabsScreenStasjonState createState() => _TabsScreenStasjonState();
}

class _TabsScreenStasjonState extends State<TabsScreenStasjon> {
  final List<String> _bottomAppBarItems = [
    customIcons.calendar,
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
          SafeArea(child: CalendarScreen()),
          NotificationScreen(),
          // The screens below are in the drawer
          WeightReportScreen(),
          SafeArea(child: MessageScreen()),
          SafeArea(child: MyPage()),
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
          isSelected: _selectedIndex > 1,
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
                  onTap: () => null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.map,
                  title: 'Stasjonene',
                  onTap: () => null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.add,
                  title: 'Utlys ekstrauttak',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExtraPickupScreen(),
                        ));
                  },
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.weight,
                  title: 'Vektuttak',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  isSelected: _selectedIndex == 2,
                ),
                DrawerButton(
                  icon: customIcons.addDiscrepancy,
                  title: 'Send beskjed',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  isSelected: _selectedIndex == 3,
                ),
                DrawerButton(
                  icon: customIcons.myPage,
                  title: 'Min side',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  isSelected: _selectedIndex == 4,
                ),
              ],
            ),
          );
        });
  }
}
