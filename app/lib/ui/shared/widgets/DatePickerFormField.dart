import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/utils/DateUtils.dart';

class DatePickerFormField extends FormField<DateTime> {
  DatePickerFormField({
    @required DateTime initialValue,
    ValueChanged<DateTime> dateChanged,
    Color backgroundColor = CustomColors.osloWhite,
    Color borderColor = CustomColors.osloLightBlue,
    bool disabled = false,
    Function(DateTime) onSaved,
    String Function(DateTime) validator,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (FormFieldState<DateTime> state) {
            Future<Null> _selectDate(BuildContext context) async {
              final DateTime picked = await showDatePicker(
                  context: context,
                  initialDate: state.value,
                  firstDate: DateTime(2015, 8),
                  lastDate: DateTime(2101));
              if (picked != null && picked != state.value) {
                state.didChange(picked);
                if (dateChanged != null) dateChanged(picked);
              }
            }

            return Builder(
              builder: (context) => Column(
                children: [
                  GestureDetector(
                    onTap: () => disabled ? null : _selectDate(context),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                border: state.hasError ||
                                        (borderColor != null && !disabled)
                                    ? Border.all(
                                        width: 2.0,
                                        color: state.hasError
                                            ? CustomColors.osloRed
                                            : borderColor,
                                      )
                                    : null),
                            child: Text(
                              state.value == null
                                  ? ""
                                  : DateUtils.months[state.value.month]
                                          .substring(0, 3) +
                                      ' ' +
                                      state.value.day.toString() +
                                      ', ' +
                                      state.value.year.toString(),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        if (!disabled)
                          RawMaterialButton(
                            onPressed: () => _selectDate(context),
                            child: CustomIcons.image(CustomIcons.arrowDownThin,
                                size: 48),
                            shape: CircleBorder(),
                            fillColor: CustomColors.osloBlue,
                            constraints: BoxConstraints(),
                          ),
                      ],
                    ),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          state.errorText,
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

// class DatePicker extends StatelessWidget {
//   final DateTime dateTime;
//   final ValueChanged<DateTime> dateChanged;
//   final Color backgroundColor;
//   final Color borderColor;
//   final bool disabled;

//   DatePicker({
//     @required this.dateTime,
//     @required this.dateChanged,
//     this.backgroundColor = CustomColors.osloWhite,
//     this.borderColor = CustomColors.osloLightBlue,
//     this.disabled = false,
//   })  : assert(dateTime != null),
//         assert(dateChanged != null);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => disabled ? null : _selectDate(context),
//       child: Row(
//         children: [
//           Flexible(
//             fit: FlexFit.tight,
//             child: Container(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                   color: backgroundColor,
//                   border: borderColor != null && !disabled
//                       ? Border.all(width: 2.0, color: borderColor)
//                       : null),
//               child: Text(
//                 DateUtils.months[dateTime.month].substring(0, 3) +
//                     ' ' +
//                     dateTime.day.toString() +
//                     ', ' +
//                     dateTime.year.toString(),
//                 style: TextStyle(fontSize: 18.0),
//               ),
//             ),
//           ),
//           RawMaterialButton(
//             onPressed: () => _selectDate(context),
//             child: CustomIcons.image(CustomIcons.arrowDownThin, size: 48),
//             shape: CircleBorder(),
//             fillColor: CustomColors.osloBlue,
//             constraints: BoxConstraints(),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Null> _selectDate(BuildContext context) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: dateTime,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != dateTime) {
//       dateChanged(picked);
//     }
//   }
// }
