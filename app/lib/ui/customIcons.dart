import 'package:flutter/material.dart';

const String add = 'add.png';
const String arrowDown = 'arrow-down.png';
const String arrowLeft = 'arrow-left.png';
const String arrowRight = 'arrow-right.png';
const String arrowUp = 'arrow-up.png';
const String checkbox = 'checkbox.png';
const String checkedCheckbox = 'checked-box.png';
const String driver = 'diver.png';
const String editIcon = 'edit-ikon.png';
const String filter = 'filter.png';
const String historyIcon = 'historie-ikon.png';
const String settings = 'innstillinger.png';
const String calendar = 'kalender.png';
const String map = 'kart.png';
const String category = 'kategori-ikon.png';
const String clock = 'klokke.png';
const String list = 'listeikon.png';
const String close = 'lukk.png';
const String addDiscrepancy = 'meld-avvik-ikon.png';
const String menu = 'meny.png';
const String mail = 'mail.png';
const String myPage = 'min-side.png';
const String mobile = 'mobil-ikon.png';
const String person = 'person.png';
const String arrowDownThin = 'pil-tynn-ned.png';
const String arrowUpThin = 'pil-tynn-opp.png';
const String refresh = 'refresh.png';
const String partners = 'sampartnere.png';
const String search = 'search.png';
const String circle = 'sirkel.png';
const String statistics = 'statistikk.png';
const String chosenCircle = 'valgt-sirkel.png';
const String notification = 'varsel-ikon.png';
const String weight = 'vekt-ikon.png';

/// Returns the icon as an Image.asset. If the icon is not found, it returns an empty Container().
Widget image(String icon, {double size = 20.0}) {
  try {
    return Image.asset('assets/icons/$icon', height: size, width: size);
  } catch (_) {
    return Container();
  }
}
