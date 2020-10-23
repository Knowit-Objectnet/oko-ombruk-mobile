import 'package:flutter/material.dart';
import 'package:ombruk/ui/myPage/MyPageView.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/zUnused/DrawerButton.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
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
                  onTap: null, //_puchCreateOccurrenceScreen,
                  isSelected: false,
                ),
                DrawerButton(
                    icon: CustomIcons.addDiscrepancy,
                    title: 'Send beskjed',
                    onTap: () {},
                    isSelected: false //_selectedIndex == 3,
                    ),
                DrawerButton(
                    icon: CustomIcons.myPage,
                    title: 'Min side',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPageView()));
                    },
                    isSelected: false //_selectedIndex == 4,
                    ),
              ],
            )));
  }
}
