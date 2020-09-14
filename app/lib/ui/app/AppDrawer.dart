import 'package:flutter/material.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/tabs/myPage/MyPage.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return Drawer(
    child: Container(color: customColors.osloDarkBlue, child:
    ListView(
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
          title: 'Opprett hendelse',
          onTap: null,//_puchCreateOccurrenceScreen,
          isSelected: false,
        ),
        DrawerButton(
          icon: customIcons.addDiscrepancy,
          title: 'Send beskjed',
          onTap: () {
            
          },
          isSelected: false//_selectedIndex == 3,
        ),
        DrawerButton(
          icon: customIcons.myPage,
          title: 'Min side',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
          },
          isSelected: false //_selectedIndex == 4,
        ),
      ],
    )
    )
  );
  }
}