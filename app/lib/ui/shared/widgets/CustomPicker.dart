import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class CustomPicker extends StatelessWidget {
  final String selectedValue;
  final List<String> values;
  final ValueChanged<String> valueChanged;
  final Function(String) validator;
  final Color backgroundColor;
  final String hintText;

  CustomPicker({
    @required this.selectedValue,
    @required this.valueChanged,
    @required this.values,
    this.validator,
    this.hintText = "",
    this.backgroundColor = CustomColors.osloWhite,
  }) : assert(valueChanged != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              iconSize: 48,
              isExpanded: true,
              isDense: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
              validator: validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              value: selectedValue,
              hint: Center(
                  child: Text(
                hintText,
                textAlign: TextAlign.center,
              )),
              icon: Container(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: CustomColors.osloLightBeige,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CustomColors.osloBlue,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomIcons.image(CustomIcons.arrowDownThin,
                            size: constraints.maxHeight);
                      },
                    ),
                  ),
                ),
              ),
              onChanged: valueChanged,
              items: values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Center(
                            child: Text(
                          e,
                          textAlign: TextAlign.center,
                        )),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
