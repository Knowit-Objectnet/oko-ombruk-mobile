import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/viewmodel/DrawerViewModel.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: DrawerViewModel(Provider.of(context)),
      builder: (context, DrawerViewModel model, _) {
        return Drawer(
          child: Container(
            color: CustomColors.osloDarkBlue,
            child: ListView(
              children: model.drawerItems
                  .map(
                    (item) => ListTile(
                      leading: CustomIcons.image(
                        item.icon,
                        size: 28,
                        color: item.isSelected
                            ? CustomColors.osloLightBlue
                            : CustomColors.osloWhite,
                      ),
                      title: Text(
                        item.title,
                        style: TextStyle(
                            color: item.isSelected
                                ? CustomColors.osloLightBlue
                                : CustomColors.osloWhite),
                      ),
                      onTap: item.onTap,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
