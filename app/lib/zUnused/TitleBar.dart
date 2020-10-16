import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

import 'package:ombruk/zUnused/AppRouter.dart';

AppRouter router; //= serviceLocator<AppRouter>();

class TitleBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          router.route.title.data,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: false,
        backgroundColor: CustomColors.osloWhite,
        elevation: 0,

        // Menu item
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          iconSize: 34,
          onPressed: () {
            router.key.currentState.openDrawer();
          },
        ),
        actions: router.route.actionItems);
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
