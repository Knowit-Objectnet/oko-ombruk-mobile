import 'package:flutter/material.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/DatePicker.dart';
import 'package:ombruk/ui/shared/widgets/form/CustomPicker.dart';
import 'package:ombruk/ui/shared/widgets/form/TimePicker.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/AddExtraPickupViewModel.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:provider/provider.dart';

class AddExtraPickupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: AddExtraPickupViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      builder: (context, AddExtraPickupViewModel model, _) => Scaffold(
        appBar: OkoAppBar(
          title: "Utlys ekstrauttak",
          backgroundColor: CustomColors.osloLightBeige,
        ),
        backgroundColor: CustomColors.osloLightBeige,
        body: model.state != ViewState.Idle
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                /// .unfocus() fixes a problem where the TextFormField isn't unfocused
                /// when the user taps outside the TextFormField.
                onTap: () => FocusScope.of(context).unfocus(),
                onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
                child: Form(
                  key: model.formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Subtitle(text: 'Velg dato for uttak'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: CustomIcons.image(CustomIcons.calendar),
                            ),
                            Expanded(
                              child: DatePicker(
                                dateTime: model.selectedDate,
                                dateChanged: model.onDateChanged,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Subtitle(text: 'Velg tidspunkt'),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CustomIcons.image(CustomIcons.clock),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: TimePicker(
                                    validator: model.validateStartTime,
                                    selectedTime: model.startTime,
                                    timeChanged: (value) => model.onTimeChanged(
                                        TimeType.Start, value),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text('-'),
                                ),
                                Expanded(
                                  child: TimePicker(
                                    validator: model.validateEndTime,
                                    selectedTime: model.endTime,
                                    timeChanged: (value) => model.onTimeChanged(
                                        TimeType.End, value),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Subtitle(text: 'Stasjon (hvem er du?)'),
                      ),
                      // This picker is to be removed. It is only temporary because we
                      // cannot get which station we are logged in as from backend yet.
                      // Jonas here. I think it's safe to remove. You can probably just pass
                      // the user group ID to the backend as the station id.
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CustomIcons.image(CustomIcons.clock),
                          ),
                          Flexible(
                            child: CustomPicker<Station>(
                              selectedValue: model.selectedStation,
                              valueChanged: model.onStationChanged,
                              validator: model.validateStation,
                              items: model.stations,
                              itemBuilder: (_, value) => DropdownMenuItem(
                                value: value,
                                child: Text(value.name),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Subtitle(text: 'Alternativt'),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 4.0),
                        decoration: BoxDecoration(
                          color: CustomColors.osloWhite,
                        ),
                        child: TextFormField(
                          controller: model.merknadController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Merknad (max 100 tegn)",
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          autofocus: false,
                          maxLength: 100, // Can be null to disable maxLength
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: model.onSubmit,
                          color: CustomColors.osloGreen,
                          child: Text('Send'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
