import 'package:flutter/material.dart';
import 'package:ombruk/ui/calendar/CalendarView.dart';
import 'package:ombruk/ui/myPage/MyPageView.dart';
import 'package:ombruk/ui/notifications/NotificationView.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

import 'package:ombruk/ui/tabs/partners/PartnerView.dart';
import 'package:ombruk/ui/tabs/stasjonComponents/MessageScreen.dart';
import 'package:ombruk/ui/weightreport/WeightReportView.dart';
import 'package:ombruk/ui/zUnused/PickupDialogPartners.dart';
import 'package:ombruk/zUnused/BottomAppBarButton.dart';
import 'package:ombruk/zUnused/DrawerButton.dart';

class TabsScreenPartner extends StatefulWidget {
  @override
  _TabsScreenPartnerState createState() => _TabsScreenPartnerState();
}

class _TabsScreenPartnerState extends State<TabsScreenPartner> {
  final List<String> _bottomAppBarItems = [
    CustomIcons.list,
    CustomIcons.weight,
    CustomIcons.notification
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        // IndexStack keeps the screen states alive between tab changes
        index: _selectedIndex,
        children: <Widget>[
          SafeArea(child: CalendarView()),
          WeightReportView(),
          NotificationView(),
          // The screens below are in the drawer
          SafeArea(child: MessageView()),
          SafeArea(child: PartnerView()),
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
        builder: (_) {
          return Container(
            color: CustomColors.osloDarkBlue,
            child: ListView(
              children: <Widget>[
                DrawerButton(
                  icon: CustomIcons.partners,
                  title: 'Sam. partnere',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 3;
                    });
                  },
                  isSelected: _selectedIndex == 3,
                ),
                DrawerButton(
                  icon: CustomIcons.map,
                  title: 'Stasjonene',
                  onTap: () => null,
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.add,
                  title: 'Søk ekstrauttak',
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => PickupDialogPartners(),
                  ),
                  isSelected: false,
                ),
                DrawerButton(
                  icon: CustomIcons.addDiscrepancy,
                  title: 'Send beskjed',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  isSelected: _selectedIndex == 4,
                ),
                DrawerButton(
                  icon: CustomIcons.myPage,
                  title: 'Min side',
                  onTap: () {
                    setState(() {
                      _selectedIndex = 5;
                    });
                  },
                  isSelected: _selectedIndex == 5,
                ),
              ],
            ),
          );
        });
  }
}
