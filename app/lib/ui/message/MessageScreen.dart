import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/DatePicker.dart';
import 'package:ombruk/ui/shared/widgets/form/CustomPicker.dart';
import 'package:ombruk/ui/shared/widgets/form/OkoIconTextField.dart';
import 'package:ombruk/ui/shared/widgets/form/TimePicker.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/MessageViewModel.dart';
import 'package:provider/provider.dart';

class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OkoAppBar(
        title: "Send beskjed",
        backgroundColor: CustomColors.osloLightBeige,
      ),
      body: BaseWidget(
        model: MessageViewModel(
          Provider.of(context),
          Provider.of(context),
          Provider.of(context),
        ),
        builder: (context, MessageViewModel model, _) => GestureDetector(
          /// .unfocus() fixes a problem where the TextFormField isn't unfocused
          /// when the user taps outside the TextFormField.
          onTap: () => FocusScope.of(context).unfocus(),
          onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
          child: Container(
            color: CustomColors.osloLightBeige,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: model.formKey,
              child: ListView(
                children: <Widget>[
                  Subtitle(text: 'Emne:'),
                  OkoTextField(
                    hint: "Emne",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Vennligst fyll ut et emne';
                      }
                      return null;
                    },
                  ),
                  Subtitle(text: 'Mottaker(e):'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomPicker<Partner>(
                      hintText: "Samarbeidspartner",
                      selectedValue: model.selectedPartner,
                      valueChanged: model.onPartnerChanged,
                      items: model.partners,
                      itemBuilder: (_, partner) => DropdownMenuItem(
                        value: partner,
                        child: Text(partner.name),
                      ),
                    ),
                  ),
                  CustomPicker<Station>(
                    hintText: "Stasjoner",
                    selectedValue: model.selectedStation,
                    valueChanged: model.onStationChanged,
                    items: model.stations,
                    itemBuilder: (_, station) => DropdownMenuItem(
                      value: station,
                      child: Text(station.name),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 10),
                    child: Subtitle(text: 'Velg periode'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Start: "),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                child: TimePicker(
                                  selectedTime: model.startTime,
                                  timeChanged: (value) => model.onTimeChanged(
                                      TimeType.Start, value),
                                ),
                              ),
                              Text('-'),
                              Flexible(
                                child: DatePicker(
                                  dateTime: model.startDate,
                                  dateChanged: (value) => model.onDateChanged(
                                      TimeType.Start, value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Slutt: "),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                child: TimePicker(
                                  selectedTime: model.startTime,
                                  timeChanged: (value) =>
                                      model.onTimeChanged(TimeType.End, value),
                                ),
                              ),
                              Text('-'),
                              Flexible(
                                child: DatePicker(
                                  dateTime: model.startDate,
                                  dateChanged: (value) =>
                                      model.onDateChanged(TimeType.End, value),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 4.0),
                      color: CustomColors.osloWhite,
                      child: TextFormField(
                        controller: model.messageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Meldingstekst (maks 200 tegn)',
                        ),
                        maxLength: 200,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Vennligst oppgi en melding';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: FlatButton(
                      onPressed: model.submitForm,
                      color: CustomColors.osloGreen,
                      child: Text('Send'),
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
