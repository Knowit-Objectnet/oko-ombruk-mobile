import 'package:flutter/material.dart';
import 'package:ombruk/const/UttaksType.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/calendar/widgets/WeekdayPicker.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/DatePickerFormField.dart';
import 'package:ombruk/ui/shared/widgets/form/CustomPickerFormField.dart';
import 'package:ombruk/ui/shared/widgets/form/TimePicker.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/CreateCalendarEventModel.dart';
import 'package:provider/provider.dart';

class CreateCalendarEvent extends StatelessWidget {
  final Station station;
  final Partner partner;

  CreateCalendarEvent({
    @required this.station,
    @required this.partner,
  })  : assert(station != null),
        assert(partner != null);
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: CreateCalendarEventModel(
        this.station,
        this.partner,
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      builder: (context, CreateCalendarEventModel model, child) => Scaffold(
        appBar: OkoAppBar(
          title: "Opprett hendelse",
          backgroundColor: CustomColors.osloLightBeige,
        ),
        backgroundColor: CustomColors.osloLightBeige,
        body: Form(
          key: model.formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Subtitle(text: station.name),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Hvor ofte skal det hentes?",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: CustomPickerFormField<String>(
                  selectedValue: model.chosenInterval,
                  valueChanged: model.onIntervalChanged,
                  items: model.intervals.toList(),
                  itemBuilder: (context, item) =>
                      DropdownMenuItem(value: item, child: Text(item)),
                ),
              ),
              if (model.chosenInterval != UttaksType.ENGANGSTILFELLE)
                Padding(
                  padding: EdgeInsets.only(bottom: 48.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Velg ukedag(er):",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                      WeekdayPicker(
                        availableWeekdays: station.hours.keys.toSet(),
                        selectedWeekdays: model.selectedWeekdays,
                        weekdaysChanged: model.onWeekdayChanged,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  "Velg tidspunkt for uttak:",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIcons.image(CustomIcons.clock, size: 35),
                    Flexible(
                      child: TimePicker(
                        isExpanded: false,
                        minTime: model.minTime,
                        maxTime: model.maxTime,
                        itemPadding: EdgeInsets.only(left: 5, right: 55),
                        selectedTime: model.startTime,
                        timeChanged: (t) =>
                            model.onTimeChanged(TimeType.Start, t),
                        validator: model.validateTime,
                      ),
                    ),
                    Text("til"),
                    Flexible(
                      child: TimePicker(
                        isExpanded: false,
                        minTime: model.minTime,
                        maxTime: model.maxTime,
                        itemPadding: EdgeInsets.only(left: 5, right: 50),
                        selectedTime: model.endTime,
                        timeChanged: (t) =>
                            model.onTimeChanged(TimeType.End, t),
                        validator: model.validateTime,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Velg periode:",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment:
                      model.chosenInterval == UttaksType.ENGANGSTILFELLE
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        right:
                            model.chosenInterval == UttaksType.ENGANGSTILFELLE
                                ? 15
                                : 0,
                      ),
                      child: CustomIcons.image(CustomIcons.calendar, size: 35),
                    ),
                    DatePickerFormField(
                      initialValue: model.startDate,
                      dateChanged: (val) =>
                          model.onDateChanged(TimeType.Start, val),
                      validator: model.validateDate,
                    ),
                    if (model.chosenInterval != UttaksType.ENGANGSTILFELLE)
                      Row(
                        children: [
                          Text("til"),
                          DatePickerFormField(
                            initialValue: model.endDate,
                            dateChanged: (val) =>
                                model.onDateChanged(TimeType.End, val),
                            validator: model.validateDate,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Alternativt:",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 8.0),
                color: CustomColors.osloWhite,
                child: TextField(
                  controller: model.merknadController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Merknad',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: FlatButton(
                  onPressed: model.onSubmit,
                  color: CustomColors.osloGreen,
                  child: Text('Opprett'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
