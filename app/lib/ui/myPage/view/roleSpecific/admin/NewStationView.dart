import 'package:flutter/material.dart';
import 'package:ombruk/ui/app/OkoAppBar.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';

import 'package:ombruk/ui/shared/widgets/TimePicker.dart';
import 'package:ombruk/ui/shared/widgets/form/OkoIconTextField.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/CreateCalendarEventModel.dart';
import 'package:ombruk/viewmodel/NewStationViewModel.dart';

class NewStationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: NewStationViewModel(),
      builder: (context, NewStationViewModel model, _) => Scaffold(
        appBar: OkoAppBar(
          title: "Legg til ny stasjon",
          backgroundColor: CustomColors.osloLightBeige,
        ),
        backgroundColor: CustomColors.osloLightBeige,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            /// .unfocus() fixes a problem where the TextFormField isn't unfocused
            /// when the user taps outside the TextFormField.
            onTap: () => FocusScope.of(context).unfocus(),
            onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
            child: Form(
              key: model.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: OkoTextField(hint: 'Navn på stasjon'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: OkoTextField(hint: 'Adresse til stasjonen'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Subtitle(text: 'Åpningstid'),
                        Text('Stengt'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Column(
                      children: DateUtils.weekdaysShort.entries
                          .map((day) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      child: Text(day.value),
                                    ),
                                    if (model.isDayClosed(day.key)) Spacer(),
                                    if (!model.isDayClosed(day.key))
                                      Expanded(
                                        child: Row(children: [
                                          Expanded(
                                            child: TimePicker(
                                              selectedTime:
                                                  model.dayOpensAt(day.key),
                                              timeChanged: (val) =>
                                                  model.onTimeChanged(
                                                      TimeType.Start,
                                                      day.key,
                                                      val),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Text("-"),
                                          ),
                                          Expanded(
                                            child: TimePicker(
                                              selectedTime:
                                                  model.dayClosesAt(day.key),
                                              timeChanged: (val) =>
                                                  model.onTimeChanged(
                                                      TimeType.Start,
                                                      day.key,
                                                      val),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor:
                                              CustomColors.osloBlack),
                                      child: Checkbox(
                                        tristate: false,
                                        activeColor:
                                            CustomColors.osloLightBeige,
                                        checkColor: CustomColors.osloBlack,
                                        value: model.isDayClosed(day.key),
                                        onChanged: (val) =>
                                            model.onClosedChange(day.key, val),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Subtitle(
                        text: 'Kontaktinformasjon til ombruksamdassadør'),
                  ),
                  OkoTextField(
                    icon: CustomIcons.image(CustomIcons.person),
                    hint: "Navn",
                  ),
                  OkoTextField(
                    icon: CustomIcons.image(CustomIcons.mobile),
                    hint: "Telefonnummer",
                  ),
                  OkoTextField(
                    icon: CustomIcons.image(CustomIcons.mail),
                    hint: "Mail adresse",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: RaisedButton(
                      onPressed: model.onSubmit,
                      color: CustomColors.osloGreen,
                      child: Text('Legg til stasjon'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
