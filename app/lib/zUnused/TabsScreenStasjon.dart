import 'package:flutter/material.dart';
import 'package:ombruk/ui/calendar/view/CalendarView.dart';
import 'package:ombruk/ui/message/MessageScreen.dart';
import 'package:ombruk/ui/myPage/MyPageView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/ui/pickup/AddExtraPickupView.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/weightreport/WeightReportView.dart';
import 'package:ombruk/zUnused/BottomAppBarButton.dart';
import 'package:ombruk/zUnused/DrawerButton.dart';
import 'package:ombruk/zUnused/ui.helper.dart';

class TabsScreenStasjon extends StatefulWidget {
  @override
  _TabsScreenStasjonState createState() => _TabsScreenStasjonState();
}

class _TabsScreenStasjonState extends State<TabsScreenStasjon> {
  // This key is used to display the Snackbar, becuase the context was hard to get from the appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> _bottomAppBarItems = [
    CustomIcons.calendar,
    CustomIcons.notification
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
          SafeArea(child: CalendarView()),
          NotificationView(),
          // The screens below are in the drawer
          WeightReportView(),
          SafeArea(child: MessageView()),
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
                  title: 'Utlys ekstrauttak',
                  onTap: () async {
                    final pickupCreated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddExtraPickupView(),
                        ));
                    if (pickupCreated != null && pickupCreated) {
                      uiHelper.showSnackbarUnknownScaffold(
                          _scaffoldKey.currentState, 'Uttaket ble registrert');
                    }
                  },
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.weight,
                  title: 'Vektuttak',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  isSelected: _selectedIndex == 2,
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
}
