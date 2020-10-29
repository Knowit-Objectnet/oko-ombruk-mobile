import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/ReturnButton.dart';
import 'package:ombruk/ui/shared/widgets/ReturnButtonTitle.dart';
import 'package:ombruk/viewmodel/NewPartnerViewModel.dart';

class NewPartnerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: NewPartnerViewModel(),
      builder: (context, NewPartnerViewModel model, child) => Scaffold(
        backgroundColor: CustomColors.osloLightBeige,
        body: GestureDetector(
          /// .unfocus() fixes a problem where the TextFormField isn't unfocused
          /// when the user taps outside the TextFormField.
          onTap: () => FocusScope.of(context).unfocus(),
          onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
          child: Form(
            key: model.formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, left: 15.0),
                  child: Row(
                    children: [
                      ReturnButton(),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:
                            ReturnButtonTitle('Legg til ny samarbeidspartner'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 16.0, bottom: 8.0, left: 15, right: 15),
                  child: Container(
                    padding: EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: CustomColors.osloWhite,
                    ),
                    child: TextFormField(
                      controller: model.partnerNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Navn på organisasjonen",
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      autofocus: false,
                      validator: model.validatePartnerName,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Last opp kontrakt',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        onPressed: () => null,
                        color: CustomColors.osloLightBlue,
                        child: Text('Bla gjennom filer'),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: model.submitForm,
                    color: CustomColors.osloGreen,
                    child: Text('Legg til samarbeidspartner'),
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
