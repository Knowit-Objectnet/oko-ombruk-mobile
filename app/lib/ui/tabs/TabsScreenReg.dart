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
          color: globals.osloDarkBlue,
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
    void onItemTapped(int index) {
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

    Widget bottomBarButton({
      @required String fileName,
      @required bool isSelected,
      @required Function onPressed,
    }) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: IconButton(
          onPressed: onPressed,
          icon: Image.asset(
            'assets/icons/$fileName',
            height: 25,
            width: 25,
            color: isSelected ? globals.osloLightBlue : globals.osloWhite,
          ),
        ),
      );
    }

    List<Widget> list = [];
    list.add(
      bottomBarButton(
          fileName: customIcons.menu,
          isSelected: false,
          onPressed: _showNavigationDrawer),
    );
    list.add(Spacer());
    for (int index = 0; index < _bottomAppBarItems.length; index++) {
      list.add(
        bottomBarButton(
            fileName: _bottomAppBarItems[index],
            isSelected: _selectedIndex == index,
            onPressed: () => onItemTapped(index)),
      );
    }
    return list;
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
                      context: context, builder: (_) => ExtraHentingDialog()),
                ),
                customListTile(customIcons.person, 'Min side', null),
                customListTile(customIcons.close, 'Logg ut (to be removed)',
                    () {
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
