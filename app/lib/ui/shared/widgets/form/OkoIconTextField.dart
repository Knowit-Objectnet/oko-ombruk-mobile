import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class OkoTextField extends StatelessWidget {
  final Widget icon;
  final String hint;
  final String Function(String) validator;
  final EdgeInsets padding;
  final Function(String) onSaved;

  OkoTextField({
    this.icon,
    this.hint,
    this.validator,
    this.onSaved,
    this.padding = const EdgeInsets.symmetric(vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: icon,
            ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.osloWhite,
                  border: Border.all(width: 2.0, color: CustomColors.osloBlue)),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  border: InputBorder.none,
                  hintText: hint,
                ),
                onSaved: onSaved,
                textCapitalization: TextCapitalization.sentences,
                autofocus: false,
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
