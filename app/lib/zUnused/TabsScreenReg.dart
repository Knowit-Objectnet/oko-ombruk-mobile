import 'package:flutter/material.dart';
import 'package:ombruk/ui/calendar/CalendarView.dart';
import 'package:ombruk/ui/message/MessageScreen.dart';
import 'package:ombruk/ui/myPage/view/MyPageView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/viewmodel/CalendarViewModel.dart';
import 'package:ombruk/zUnused/BottomAppBarButton.dart';
import 'package:ombruk/zUnused/DrawerButton.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/ui/ui.helper.dart';

class TabsScreenReg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<dynamic, CalendarViewModel>(
      builder: (
        context,
        dynamic userViewModel,
        CalendarViewModel calendarViewModel,
        _,
      ) {
        return _TabsScreenRegConsumed(userViewModel, calendarViewModel);
      },
    );
  }
}

class _TabsScreenRegConsumed extends StatefulWidget {
  final dynamic userViewModel;
  final CalendarViewModel calendarViewModel;

  _TabsScreenRegConsumed(this.userViewModel, this.calendarViewModel);

  @override
  _TabsScreenRegConsumedState createState() => _TabsScreenRegConsumedState();
}

class _TabsScreenRegConsumedState extends State<_TabsScreenRegConsumed> {
  // This key is used to display the Snackbar, becuase the context was hard to get from the appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _bottomAppBarItems = [
    CustomIcons.notification,
    CustomIcons.calendar,
    CustomIcons.statistics
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: IndexedStack(
        // IndexStack keeps the screen states alive between tab changes
        index: _selectedIndex,
        children: <Widget>[
          NotificationView(),
          SafeArea(child: CalendarView()),
          NotificationView(),
          // The screens below are in the drawer
          MessageView(),
          SafeArea(child: MyPageView()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: CustomColors.osloDarkBlue,
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
          icon: CustomIcons.menu,
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
        builder: (context) {
          return Container(
            color: CustomColors.osloDarkBlue,
            child: ListView(
              children: <Widget>[
                DrawerButton(
                  icon: CustomIcons.partners,
                  title: 'Sam. partnere',
                  onTap: () => null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.map,
                  title: 'Stasjonene',
                  onTap: () => null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.add,
                  title: 'Opprett hendelse',
                  onTap: _puchCreateOccurrenceScreen,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.addDiscrepancy,
                  title: 'Send beskjed',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  isSelected: _selectedIndex == 3,
                ),
                DrawerButton(
                  icon: CustomIcons.myPage,
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

  Future<void> _puchCreateOccurrenceScreen() async {
    // final occurrenceAdded = await Navigator.push(
    //   context,
    //   MaterialPageRoute<bool>(
    //     builder: (context) => CreateOccurrenceScreen(),
    //   ),
    // );
    // if (occurrenceAdded != null && occurrenceAdded) {
    //   uiHelper.showSnackbarUnknownScaffold(
    //       _scaffoldKey.currentState, 'Opprettet hendelsen!');
    //   widget.calendarViewModel.fetchEvents();
    // }
  }
}
