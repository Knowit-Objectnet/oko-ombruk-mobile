import 'package:flutter/material.dart';

import 'package:ombruk/models/CalendarEvent.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/DatePickerFormField.dart';
import 'package:ombruk/ui/shared/widgets/form/TimePicker.dart';
import 'package:ombruk/utils/DateUtils.dart';
import 'package:ombruk/viewmodel/CalendarEventExpandedModel.dart';

import 'package:provider/provider.dart';

class CalendarEventExpander extends StatelessWidget {
  final CalendarEvent event;
  CalendarEventExpander({
    @required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: CalendarEventExpandedModel(
        event,
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      onModelReady: (CalendarEventExpandedModel model) => model.init(),
      builder: (context, CalendarEventExpandedModel model, _) => Container(
        color: CustomColors.osloWhite,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Form(
              key: model.updateFormKey,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomIcons.image(CustomIcons.calendar, size: 25),
                      VerticalDivider(thickness: 50),
                      Flexible(
                        child: DatePickerFormField(
                          validator: model.validateDate,
                          disabled: !model.isEditing,
                          initialValue: model.date,
                          dateChanged: model.onDateChanged,
                        ),
                      ),
                      if (!model.isEditing && model.hasPrivileges)
                        RawMaterialButton(
                          child: CustomIcons.image(CustomIcons.editIcon),
                          fillColor: CustomColors.osloBlue,
                          padding: const EdgeInsets.all(5),
                          constraints: BoxConstraints(),
                          onPressed: model.setEditing,
                          shape: CircleBorder(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 40),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        CustomIcons.image(CustomIcons.clock, size: 25),
                        Padding(padding: const EdgeInsets.only(right: 15)),
                        Flexible(
                          child: TimePicker(
                            minTime: model.minTime,
                            maxTime: model.maxTime,
                            disabled: !model.isEditing,
                            iconBackgroundColor: CustomColors.osloWhite,
                            selectedTime: model.startTime,
                            validator: model.validateTime,
                            timeChanged: (time) =>
                                model.onTimeChanged(TimeType.Start, time),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text("til"),
                        ),
                        Flexible(
                          child: TimePicker(
                            minTime: model.minTime,
                            maxTime: model.maxTime,
                            iconBackgroundColor: CustomColors.osloWhite,
                            disabled: !model.isEditing,
                            selectedTime: model.endTime,
                            validator: model.validateTime,
                            timeChanged: (time) =>
                                model.onTimeChanged(TimeType.End, time),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  Row(
                    children: <Widget>[
                      CustomIcons.image(CustomIcons.map, size: 25),
                      VerticalDivider(thickness: 100),
                      Text(
                        model.event.station.name.toString(),
                        style: TextStyle(fontSize: 18.0),
                      )
                    ],
                  ),
                  if (model.isEditing)
                    ButtonBar(
                      children: [
                        RawMaterialButton(
                          fillColor: CustomColors.osloRed,
                          child: CustomIcons.image(CustomIcons.close),
                          onPressed: model.setEditing,
                          shape: CircleBorder(),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(7),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        RawMaterialButton(
                          fillColor: CustomColors.osloGreen,
                          child: Icon(
                            Icons.check, // TODO: add proper icon
                            color: CustomColors.osloBlack,
                          ),
                          onPressed: model.updateCalendarEvent,
                          shape: CircleBorder(),
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.all(7),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        )
                      ],
                    ),
                ],
              ),
            ),
            if (!model.isEditing)
              ExpansionTile(
                tilePadding: EdgeInsets.all(0),
                childrenPadding: EdgeInsets.all(0),
                title: Text('Avlys uttak',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: CustomColors.osloBlack,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: CircleAvatar(
                  backgroundColor: CustomColors.osloRed,
                  radius: 20.0,
                  child: model.isExpanded
                      ? CustomIcons.image(CustomIcons.arrowUpThin)
                      : CustomIcons.image(CustomIcons.arrowDownThin),
                ),
                onExpansionChanged: (_) => model.cancelExpanded(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                activeColor: CustomColors.osloBlack,
                                groupValue: model.cancellationType,
                                value: CancellationType.Once,
                                onChanged: model.onCancelTypeChanged,
                              ),
                            ),
                            Text('Engangstilfelle')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Transform.scale(
                                scale: 1.5,
                                child: Radio(
                                  activeColor: CustomColors.osloBlack,
                                  groupValue: model.cancellationType,
                                  value: CancellationType.Until,
                                  onChanged: model.onCancelTypeChanged,
                                )),
                            Text('Periode')
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (model.cancellationType == CancellationType.Until)
                    Form(
                      key: model.deleteFormKey,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text('Sluttdato:',
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Flexible(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, bottom: 10),
                              child: DatePickerFormField(
                                validator: model.validateUntilDate,
                                initialValue: model.cancelUntilDateTime,
                                dateChanged: model.onCancelEndChanged,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  FlatButton(
                      onPressed: model.deleteEvents,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 120,
                        vertical: 10,
                      ),
                      color: CustomColors.osloGreen,
                      child: Text('Bekreft',
                          style: TextStyle(fontWeight: FontWeight.bold)))
                ],
              ),
          ],
        ),
      ),
    );
  }
}
