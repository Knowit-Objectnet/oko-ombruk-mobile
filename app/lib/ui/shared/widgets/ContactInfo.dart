import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/ContactInfoField.dart';

class ContactInfo extends StatelessWidget {
  final Widget title;
  final String name;
  final String phone;
  final String email;
  final String role;
  ContactInfo({
    this.title,
    this.name,
    this.phone,
    this.email,
    this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title != null) title,
        if (name != null)
          ContactInfoField(
            value: name,
            icon: CustomIcons.image(CustomIcons.person),
          ),
        if (phone != null)
          ContactInfoField(
            value: phone,
            icon: CustomIcons.image(CustomIcons.person),
          ),
        if (email != null)
          ContactInfoField(
            value: email,
            icon: CustomIcons.image(CustomIcons.person),
          ),
        if (role != null) ContactInfoField(value: role),
      ],
    );
  }
}
