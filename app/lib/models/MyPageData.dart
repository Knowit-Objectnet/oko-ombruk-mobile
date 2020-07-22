import 'dart:convert';
import 'package:meta/meta.dart';

// TODO: Unit test this class and its json (de)serializer

class MyPageData {
  final String name;
  final String about;
  final bool shareContactInfo;
  final List<_MainContact> mainContacts;
  final List<_Chauffeur> chauffeurs;

  MyPageData({
    @required this.name,
    @required this.about,
    @required this.shareContactInfo,
    @required this.mainContacts,
    @required this.chauffeurs,
  });

  factory MyPageData.fromJson(Map<String, dynamic> json) {
    List<dynamic> contactList = jsonDecode(json['mainContacts']);
    List<dynamic> chauffeurList = jsonDecode(json['chauffeurs']);

    return MyPageData(
      name: json['name'],
      about: json['about'],
      shareContactInfo: json['shareContactInfo'],
      mainContacts: contactList.map((e) => _MainContact.fromJson(e)).toList(),
      chauffeurs: chauffeurList.map((e) => _Chauffeur.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'about': about,
        'shareContactInfo': shareContactInfo,
      };
}

class _MainContact {
  final String name;
  final String phone;
  final String email;
  final String about;

  _MainContact.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        about = json['about'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'about': about,
      };
}

class _Chauffeur {
  final String name;
  final String phone;

  _Chauffeur.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
      };
}
