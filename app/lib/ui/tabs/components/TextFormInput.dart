import 'package:flutter/material.dart';
import 'package:ombruk/ui/customColors.dart' as customColors;

class TextFormInput extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final Color borderColor;
  final int maxLength;
  final bool validate;

  TextFormInput({
    @required this.hint,
    @required this.controller,
    this.borderColor,
    this.maxLength,
    this.validate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      decoration: BoxDecoration(
          color: customColors.osloWhite,
          border: borderColor != null
              ? Border.all(width: 2.0, color: borderColor)
              : null),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        maxLength: maxLength, // Can be null to disable maxLength
        validator: (value) {
          if (validate && value.isEmpty) {
            return 'Vennligst fyll ut feltet';
          }
          return null;
        },
      ),
    );
  }
}
