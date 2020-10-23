import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/CustomPicker.dart';
import 'package:ombruk/ui/shared/widgets/ReturnButton.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/viewmodel/BaseViewModel.dart';
import 'package:ombruk/viewmodel/CreateOccurenceViewModel.dart';
import 'package:provider/provider.dart';

class CreateOccurenceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: CreateOccurenceViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      builder: (context, CreateOccurenceViewModel model, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Opprett hendelse",
              style: TextStyle(
                  color: CustomColors.osloDarkBlue,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: CustomColors.osloLightBeige,
            leading: Padding(
                padding: EdgeInsets.only(left: 5),
                child: ReturnButton(returnValue: false)),
          ),
          backgroundColor: CustomColors.osloLightBeige,
          body: model.state == ViewState.Busy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: model.formKey,
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
                        child: Subtitle(text: 'Samarbeidspartner'),
                      ),
                      CustomPicker(
                        hintText: "Velg partner",
                        values: model.partners.map((e) => e.name).toList(),
                        selectedValue: model.selectedPartner?.name,
                        valueChanged: model.onPartnerChanged,
                        validator: model.pickerValidator,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
                        child: Subtitle(text: 'Stasjon(er)'),
                      ),
                      CustomPicker(
                        hintText: "Velg Stasjon",
                        values: model.stations.map((e) => e.name).toList(),
                        selectedValue: model.selectedStation?.name,
                        valueChanged: model.onStationChanged,
                        validator: model.pickerValidator,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: FlatButton(
                          onPressed: model.onNextPressed,
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Neste',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              CustomIcons.image(CustomIcons.arrowRight,
                                  size: 48),
                            ],
                          ),
                          color: CustomColors.osloBlue,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
