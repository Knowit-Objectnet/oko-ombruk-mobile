import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class CustomPickerFormField<T> extends FormField<T> {
  final T selectedValue;
  final List<T> items;
  final DropdownMenuItem<T> Function(BuildContext context, T value) itemBuilder;
  final ValueChanged<T> valueChanged;
  final String Function(T) validator;
  final Color backgroundColor;
  final String hintText;
  final bool disabled;
  final Widget disabledWidget;
  final Widget icon;
  final Color borderColor;
  final Color iconBackgroundColor;
  final bool isExpanded;

  CustomPickerFormField({
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
    this.isExpanded = true,
  }) : super(
          validator: validator,
          initialValue: selectedValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<T> state) {
            void _valueChanged(T val) {
              if (val != state.value) {
                state.didChange(val);
                valueChanged(val);
              }
            }

            return disabled
                ? disabledWidget
                : Builder(
                    builder: (context) => Column(
                      children: [
                        Container(
                          color: backgroundColor,
                          child: DropdownButton(
                            iconSize: 40,
                            isExpanded: isExpanded,
                            underline: const SizedBox(),
                            hint: selectedValue == null
                                ? Center(
                                    child: Text(
                                    hintText,
                                    textAlign: TextAlign.center,
                                  ))
                                : null,
                            selectedItemBuilder: state.value == null
                                ? null
                                : (context) => items
                                    .map((item) => Container(
                                          decoration: BoxDecoration(
                                            color: CustomColors.osloWhite,
                                            border: Border.all(
                                              color: state.hasError
                                                  ? CustomColors.osloRed
                                                  : borderColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: itemBuilder(context, item),
                                        ))
                                    .toList(),
                            icon: Container(
                              color: iconBackgroundColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.osloLightBlue,
                                ),
                                child: CustomIcons.image(
                                  CustomIcons.arrowDownThin,
                                  size: 48,
                                ),
                              ),
                            ),
                            value: state.value,
                            items: items
                                .map((e) => itemBuilder(context, e))
                                .toList(),
                            onChanged: _valueChanged,
                          ),
                        ),
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                state.errorText,
                                softWrap: true,
                                style: TextStyle(
                                  color: CustomColors.osloRed,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
          },
        );
}
