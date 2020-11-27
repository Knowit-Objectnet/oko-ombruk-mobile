import 'package:flutter/material.dart';
import 'package:ombruk/ui/app/widgets/OkoAppBar.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';
import 'package:ombruk/ui/shared/widgets/BaseWidget.dart';
import 'package:ombruk/ui/shared/widgets/ContactInfo.dart';
import 'package:ombruk/ui/shared/widgets/button/OkoTextButton.dart';
import 'package:ombruk/ui/shared/widgets/button/SwitchButton.dart';
import 'package:ombruk/ui/shared/widgets/text/Subtitle.dart';
import 'package:ombruk/viewmodel/MyPageViewModel.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/globals.dart';

class MyPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: MyPageViewModel(
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
        Provider.of(context),
      ),
      onModelReady: (MyPageViewModel model) => model.init(),
      builder: (context, MyPageViewModel model, _) => Scaffold(
        backgroundColor: CustomColors.osloWhite,
        appBar: OkoAppBar(
          title: "Min side",
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: CustomColors.osloDarkBlue,
                child: Text(
                  'Logg ut',
                  style: TextStyle(color: CustomColors.osloWhite),
                ),
                onPressed: model.requestLogOut,
              ),
            )
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            if (model.role == KeycloakRoles.partner)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Subtitle(text: 'Om Fretex'),
                    Text(
                        'Fretex skal bidra til at mennesker får og beholder arbeid. Fretex skal bidra til et bedre miljø gjennom blant annet gjenbruk og gjenvinning. Selskapets virksomhet skal drives i overensstemmelse med Frelsesarmeens verdigrunnlag.'),
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ContactInfo(
                title: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Subtitle(text: "Min Kontaktinfo"),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CircleAvatar(
                        backgroundColor: CustomColors.osloLightBlue,
                        child: IconButton(
                          onPressed: () => null,
                          icon: CustomIcons.image(CustomIcons.editIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                name: "Fretex",
                phone: "+47 49219823",
                email: "mail.adresse@gmail.com",
                role: "Ombrukskoordinator",
              ),
            ),
            if (model.role == KeycloakRoles.partner)
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Subtitle(text: 'Kontaktinformasjon'),
                        Text(
                            'Vil dere dele kontaktinformasjonen til de andre samarbeidspartnerne for å øke samarbeidet rundt ombruk?'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Deling',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: CustomColors.osloDarkBlue,
                            ),
                          ),
                        ),
                        SwitchButton(
                          activated: model.showContactInfo,
                          textOn: 'På',
                          textOff: 'Av',
                          buttonPressed: model.onShowContactInfoChanged,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            if (model.role == KeycloakRoles.reg_employee)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OkoTextButton(
                      icon: CustomIcons.image(CustomIcons.add, size: 30),
                      text: "Legg til ny samarbeidspartner",
                      onPressed: model.onNewPartner,
                    ),
                    OkoTextButton(
                      icon: CustomIcons.image(CustomIcons.add, size: 30),
                      text: "Legg til ny stasjon",
                      onPressed: model.onNewStation,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                    ),
                    OkoTextButton(
                      onPressed: () => print("Remove"),
                      iconBackgroundColor: CustomColors.osloRed,
                      text: "Slett samarbeidspartner",
                      icon: CustomIcons.image(CustomIcons.close, size: 30),
                    ),
                    OkoTextButton(
                      onPressed: () => print("Remove"),
                      iconBackgroundColor: CustomColors.osloRed,
                      text: "Slett Stasjon",
                      icon: CustomIcons.image(CustomIcons.close, size: 30),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
