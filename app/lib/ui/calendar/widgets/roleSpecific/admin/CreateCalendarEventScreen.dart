import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/CustomPicker.dart';
import 'package:ombruk/ui/shared/widgets/DatePicker.dart';
import 'package:ombruk/ui/shared/widgets/ReturnButton.dart';
import 'package:ombruk/ui/shared/widgets/TimePicker.dart';
import 'package:ombruk/ui/shared/widgets/WeekdayPicker.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
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
        appBar: AppBar(
          title: Text(
            "Opprett hendelse",
            style: TextStyle(
                color: CustomColors.osloDarkBlue, fontWeight: FontWeight.bold),
          ),
          backgroundColor: CustomColors.osloLightBeige,
          leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: ReturnButton(returnValue: false)),
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
              CustomPicker(
                selectedValue: model.chosenInterval,
                valueChanged: model.onIntervalChanged,
                values: model.intervals.keys.toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Velg ukedag(er):",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              WeekdayPicker(
                selectedWeekdays: model.selectedWeekdays,
                weekdaysChanged: model.onWeekdayChanged,
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Velg tidspunkt for uttak:",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomIcons.image(CustomIcons.clock),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TimePicker(
                            selectedTime: model.startTime,
                            timeChanged: (t) =>
                                model.onTimeChanged(TimeType.Start, t),
                          ),
                          Text("til"),
                          TimePicker(
                            selectedTime: model.endTime,
                            timeChanged: (t) =>
                                model.onTimeChanged(TimeType.End, t),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: Text(
                  "Velg periode:",
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomIcons.image(CustomIcons.calendar),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          DatePicker(
                            dateTime: model.startDate,
                            dateChanged: (val) =>
                                model.onDateChanged(TimeType.Start, val),
                          ),
                          Text("til"),
                          DatePicker(
                            dateTime: model.endDate,
                            dateChanged: (val) =>
                                model.onDateChanged(TimeType.End, val),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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
