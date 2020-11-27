import 'package:flutter/material.dart';
import 'package:ombruk/routing/AppRouter.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/TabViewModel.dart';
import 'package:provider/provider.dart';

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: TabViewModel(Provider.of(context), Provider.of(context)),
      onModelReady: (TabViewModel model) async => await model.init(),
      builder: (context, TabViewModel model, _) => WillPopScope(
        onWillPop: model.willPop,
        child: Scaffold(
          key: model.scaffoldKey,
          body: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :
              // Indexed stack to retain view state after navigation
              IndexedStack(
                  index: model.index,
                  children: model.view.navItems
                      .map(
                        (item) => Navigator(
                          key: item.navigatorKey,
                          initialRoute: item.routeName,
                          onGenerateRoute: (route) =>
                              AppRouter.generateRoute(route),
                        ),
                      )
                      .toList(),
                ),
          // Navigation bar
          bottomNavigationBar: model.state == ViewState.Busy
              ? null
              : BottomNavigationBar(
                  backgroundColor: CustomColors.osloDarkBlue,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  // Change current index on tap
                  onTap: (index) => model.onTabChanged(index),
                  currentIndex: model.index,
                  items: model.view.navItems
                      .map(
                        (item) => BottomNavigationBarItem(
                          icon: item.icon,
                          label: item.label,
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
