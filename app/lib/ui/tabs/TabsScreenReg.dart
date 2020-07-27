import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';
import 'package:ombruk/blocs/CalendarBloc.dart';

import 'package:ombruk/DataProvider/CalendarApiClient.dart';

import 'package:ombruk/repositories/CalendarRepository.dart';

import 'package:ombruk/ui/tabs/RegComponents/CreateCalendarEventScreen.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/calendar/CalendarBlocBuilder.dart';
import 'package:ombruk/ui/tabs/ExtraHentingPopup/ExtraHentingDialog.dart';
import 'package:ombruk/ui/tabs/notifications/NotificationScreen.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/BottomAppBarButton.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class TabsScreenReg extends StatefulWidget {
  @override
  _TabsScreenRegState createState() => _TabsScreenRegState();
}

class _TabsScreenRegState extends State<TabsScreenReg> {
  int _selectedIndex = 0;
  List<String> _bottomAppBarItems = [
    customIcons.list,
    customIcons.calendar,
    customIcons.statistics
  ];

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
            SafeArea(child: CalendarBlocBuilder()),
            SafeArea(child: CreateCalendarEventScreen()),
            NotificationScreen(),
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
                DrawerButton(customIcons.partners, 'Sam. partnere', null),
                DrawerButton(customIcons.map, 'Stasjonene', null),
                DrawerButton(
                  customIcons.add,
                  'Søk ekstrauttak',
                  () => showDialog(
                      context: context, builder: (_) => ExtraHentingDialog()),
                ),
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
