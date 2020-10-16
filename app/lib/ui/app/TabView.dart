import 'package:flutter/material.dart';
import 'package:ombruk/AppRouter.dart';
import 'package:ombruk/ui/app/DrawerButton.dart';
import 'package:ombruk/ui/myPage/MyPageView.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/viewmodel/TabViewModel.dart';
import 'package:provider/provider.dart';

class TabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return BaseWidget(
      model: TabViewModel(Provider.of(context), Provider.of(context)),
      builder: (context, TabViewModel model, _) => Scaffold(
          // App bar
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              model.view.navItems[model.index].label,
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
                _scaffoldKey.currentState.openDrawer();
                //model.view.key.currentState.openDrawer();
              },
            ),
          ),
          // actions: model.view.actionItems),
          // Body with safe area
          body: SafeArea(
            // Indexed stack to retain view state after navigation
            child: IndexedStack(
              index: model.index,
              children: model.view.navItems
                  .map(
                    (item) => Navigator(
                      key: item.navigatorKey,
                      onGenerateRoute: (route) =>
                          route.name == "/" || route.name == null
                              ? AppRouter.generateRoute(
                                  RouteSettings(name: item.routeName))
                              : AppRouter.generateRoute(route),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Side menu drawer
          drawer: Drawer(
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
              ),
            ),
          ),
          // Navigation bar
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: CustomColors.osloDarkBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            // Change current index on tap
            onTap: (index) => model.onTabChanged(index),
            currentIndex: model.index,
            items: model.view.navItems
                .map(
                  (item) => BottomNavigationBarItem(
                      icon: Icon(item.iconData), label: item.label),
                )
                .toList(),
          )),
    );
  }
}
