import 'package:flutter/widgets.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

abstract class CustomIcons {
  static const String add = 'add.png';
  static const String arrowDown = 'arrow-down.png';
  static const String arrowLeft = 'arrow-left.png';
  static const String arrowRight = 'arrow-right.png';
  static const String arrowUp = 'arrow-up.png';
  static const String checkbox = 'checkbox.png';
  static const String checkedCheckbox = 'checked-box.png';
  static const String driver = 'driver.png';
  static const String editIcon = 'edit-ikon.png';
  static const String filter = 'filter.png';
  static const String historyIcon = 'historie-ikon.png';
  static const String settings = 'innstillinger.png';
  static const String calendar = 'kalender.png';
  static const String map = 'kart.png';
  static const String category = 'kategori-ikon.png';
  static const String clock = 'klokke.png';
  static const String list = 'listeikon.png';
  static const String close = 'lukk.png';
  static const String addDiscrepancy = 'meld-avvik-ikon.png';
  static const String menu = 'meny.png';
  static const String mail = 'mail.png';
  static const String myPage = 'min-side.png';
  static const String mobile = 'mobil-ikon.png';
  static const String person = 'person.png';
  static const String arrowDownThin = 'pil-tynn-ned.png';
  static const String arrowUpThin = 'pil-tynn-opp.png';
  static const String refresh = 'refresh.png';
  static const String partners = 'sampartnere.png';
  static const String search = 'search.png';
  static const String circle = 'sirkel.png';
  static const String statistics = 'statistikk.png';
  static const String chosenCircle = 'valgt-sirkel.png';
  static const String notification = 'varsel-ikon.png';
  static const String weight = 'vekt-ikon.png';

  /// Returns the icon as an Image.asset. If the icon is not found, it returns an empty Container().
  static Widget image(String icon,
      {double size = 20.0, Color color = CustomColors.osloBlack}) {
    return Image.asset(
      'assets/icons/$icon',
      height: size,
      width: size,
      color: color,
      errorBuilder: (context, object, stackTrace) {
        // Called if the icon path is not found in assets
        print('Icon $icon is not included in assets');
        return Container(height: 20, width: 20);
      },
    );
  }
}
