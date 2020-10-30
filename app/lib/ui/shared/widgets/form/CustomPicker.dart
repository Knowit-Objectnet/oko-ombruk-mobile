import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class CustomPicker<T> extends StatelessWidget {
  final T selectedValue;
  final List<T> items;
  final DropdownMenuItem<T> Function(BuildContext context, T value) itemBuilder;
  final ValueChanged<T> valueChanged;
  final Function(T) validator;
  final Color backgroundColor;
  final String hintText;
  final bool disabled;
  final Widget disabledWidget;
  final Widget icon;
  final Color borderColor;
  final Color iconBackgroundColor;

  CustomPicker({
    @required this.selectedValue,
    @required this.valueChanged,
    @required this.items,
    @required this.itemBuilder,
    this.validator,
    this.disabled = false,
    this.disabledWidget = const SizedBox(),
    this.hintText = "",
    this.icon,
    this.iconBackgroundColor = CustomColors.osloLightBeige,
    this.borderColor = CustomColors.osloLightBlue,
    this.backgroundColor = CustomColors.osloWhite,
  }) : assert(valueChanged != null);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: disabled
          ? disabledWidget
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) icon,
                Flexible(
                  child: DropdownButtonFormField<T>(
                    selectedItemBuilder: selectedValue == null
                        ? null
                        : (context) => items
                            .map((item) => Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: borderColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: itemBuilder(context, item),
                                ))
                            .toList(),
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
                    hint: selectedValue == null
                        ? Center(
                            child: Text(
                            hintText,
                            textAlign: TextAlign.center,
                          ))
                        : null,
                    icon: Container(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: iconBackgroundColor,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.osloBlue,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return CustomIcons.image(
                                  CustomIcons.arrowDownThin,
                                  size: constraints.maxHeight);
                            },
                          ),
                        ),
                      ),
                    ),
                    onChanged: valueChanged,
                    items: items
                        .map((value) => itemBuilder(context, value))
                        .toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
