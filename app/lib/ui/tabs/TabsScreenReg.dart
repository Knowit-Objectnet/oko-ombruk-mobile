import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';

import 'package:ombruk/repositories/CalendarRepository.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventScreen.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';
import 'package:ombruk/ui/tabs/myPage/MyPage.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/BottomAppBarButton.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/tabs/stasjonComponents/MessageScreen.dart';

class TabsScreenReg extends StatefulWidget {
  @override
  _TabsScreenRegState createState() => _TabsScreenRegState();
}

class _TabsScreenRegState extends State<TabsScreenReg> {
  final List<String> _bottomAppBarItems = [
    customIcons.notification,
    customIcons.calendar,
    customIcons.statistics
  ];

  int _selectedIndex = 0;

  final CalendarRepository calendarRepository =
      CalendarRepository(apiClient: CalendarApiClient());

  @override
  Widget build(BuildContext context) {
    // Calendar Bloc needs to be accessed in both Calendar screen and createCalendarEvent screen
    return BlocProvider(
      create: (context) => CalendarBloc(calendarRepository: calendarRepository)
        ..add(CalendarInitialEventsRequested()),
      child: Scaffold(
        body: IndexedStack(
          // IndexStack keeps the screen states alive between tab changes
          index: _selectedIndex,
          children: <Widget>[
            NotificationScreen(),
            SafeArea(child: CalendarBlocBuilder()),
            NotificationScreen(),
            // The screens below are in the drawer
            SafeArea(child: CreateCalendarEventScreen()),
            MessageScreen(),
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
                  onTap: null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.map,
                  title: 'Stasjonene',
                  onTap: null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: customIcons.add,
                  title: 'Opprett hendelse',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  isSelected: _selectedIndex == 3,
                ),
                DrawerButton(
                  icon: customIcons.addDiscrepancy,
                  title: 'Send beskjed',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  isSelected: _selectedIndex == 4,
                ),
                DrawerButton(
                  icon: customIcons.person,
                  title: 'Min side',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                  isSelected: _selectedIndex == 5,
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
