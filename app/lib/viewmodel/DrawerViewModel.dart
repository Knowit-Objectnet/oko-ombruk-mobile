import 'package:ombruk/const/Routes.dart';
import 'package:ombruk/services/interfaces/INavigatorService.dart';
import 'package:ombruk/ui/app/DrawerItem.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';

class DrawerViewModel extends BaseViewModel {
  final INavigatorService _navigatorService;
  List<DrawerItem> drawerItems;
  DrawerViewModel(this._navigatorService) {
    drawerItems = [
      DrawerItem(
        icon: CustomIcons.partners,
        title: 'Sam. partnere',
        onTap: () => null,
        isSelected: false,
      ),
      DrawerItem(
        icon: CustomIcons.map,
        title: 'Stasjonene',
        onTap: () => _navigatorService.closeScaffold(),
        isSelected: false,
      ),
      DrawerItem(
        icon: CustomIcons.add,
        title: 'Opprett hendelse',
        onTap: () {
          _navigatorService.closeScaffold();
          _navigatorService.navigateTo(Routes.CreateOccurenceView);
        },
        isSelected: false,
      ),
      DrawerItem(
          icon: CustomIcons.addDiscrepancy,
          title: 'Send beskjed',
          onTap: () {
            _navigatorService.closeScaffold();
          },
          isSelected: false //_selectedIndex == 3,
          ),
      DrawerItem(
          icon: CustomIcons.myPage,
          title: 'Min side',
          onTap: () {
            _navigatorService.closeScaffold();
            _navigatorService.navigateTo(Routes.MinSideView);
          },
          isSelected: false //_selectedIndex == 4,
          ),
    ];
  }
}
