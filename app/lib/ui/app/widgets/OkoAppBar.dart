import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/ReturnButton.dart';

class OkoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final Color backgroundColor;
  final bool showBackButton;
  OkoAppBar({
    @required this.title,
    this.actions,
    this.backgroundColor = CustomColors.osloWhite,
    this.showBackButton = true,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
      ),
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ReturnButton(),
            )
          : null,
      centerTitle: false,
      backgroundColor: backgroundColor,
      brightness: Brightness.light,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
