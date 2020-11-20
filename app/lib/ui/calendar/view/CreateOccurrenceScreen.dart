import 'package:flutter/material.dart';
import 'package:ombruk/models/Partner.dart';
import 'package:ombruk/models/Station.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/form/CustomPickerFormField.dart';
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
          appBar: OkoAppBar(
            title: "Opprett hendelse",
            backgroundColor: CustomColors.osloLightBeige,
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
                      // DropdownButton(
                      //   items: model.partners
                      //       .map((partner) => DropdownMenuItem(
                      //             value: partner,
                      //             child: Center(
                      //               child: Text(
                      //                 partner.name,
                      //                 textAlign: TextAlign.center,
                      //               ),
                      //             ),
                      //           ))
                      //       .toList(),
                      //   onChanged: model.onPartnerChanged,
                      // ),
                      CustomPickerFormField<Partner>(
                        hintText: "Velg partner",
                        selectedValue: model.selectedPartner,
                        valueChanged: model.onPartnerChanged,
                        validator: model.pickerValidator,
                        items: model.partners,
                        itemBuilder: (context, partner) => DropdownMenuItem(
                          value: partner,
                          child: Center(
                            child: Container(
                              child: Text(
                                partner.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24.0, bottom: 4.0),
                        child: Subtitle(text: 'Stasjon(er)'),
                      ),
                      CustomPickerFormField<Station>(
                        hintText: "Velg Stasjon",
                        selectedValue: model.selectedStation,
                        valueChanged: model.onStationChanged,
                        validator: model.pickerValidator,
                        items: model.stations,
                        itemBuilder: (context, station) => DropdownMenuItem(
                          value: station,
                          child: Container(
                            child: Center(
                              child: Text(
                                station.name,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
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
