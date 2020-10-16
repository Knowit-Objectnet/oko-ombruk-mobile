import 'package:flutter/material.dart';
import 'package:ombruk/ClassRouter.dart';
import 'package:ombruk/globals.dart';
import 'package:ombruk/ui/tabs/bottomAppBarComponents/DrawerButton.dart';
import 'package:ombruk/ui/tabs/myPage/MyPage.dart';
import 'package:ombruk/ui/views/BaseWidget.dart';
import 'package:ombruk/viewmodel/TabViewModel.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:provider/provider.dart';

class TabView extends StatelessWidget {
  final KeycloakRoles role;
  TabView(this.role) {
    print("View $role");
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return BaseWidget(
      model: TabViewModel(role, Provider.of(context)),
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
            backgroundColor: customColors.osloWhite,
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
              color: customColors.osloDarkBlue,
              child: ListView(
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
                    onTap: null, //_puchCreateOccurrenceScreen,
                    isSelected: false,
                  ),
                  DrawerButton(
                      icon: customIcons.addDiscrepancy,
                      title: 'Send beskjed',
                      onTap: () {},
                      isSelected: false //_selectedIndex == 3,
                      ),
                  DrawerButton(
                      icon: customIcons.myPage,
                      title: 'Min side',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyPage()));
                      },
                      isSelected: false //_selectedIndex == 4,
                      ),
                ],
              ),
            ),
          ),
          // Navigation bar
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: customColors.osloDarkBlue,
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
