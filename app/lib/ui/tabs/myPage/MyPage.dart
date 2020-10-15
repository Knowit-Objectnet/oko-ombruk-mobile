import 'package:flutter/material.dart';
import 'package:ombruk/ui/views/BaseWidget.dart';
import 'package:ombruk/viewmodel/MyPageViewModel.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/ui/tabs/RegComponents/NewStationScreen.dart';
import 'package:ombruk/ui/tabs/RegComponents/NewPartnerScreen.dart';
import 'package:ombruk/ui/tabs/components/SwitchButton.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/globals.dart' as globals;
import 'package:ombruk/ui/ui.helper.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: MyPageViewModel(Provider.of(context), Provider.of(context)),
      builder: (context, model, _) => Scaffold(
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: customIcons.image(customIcons.myPage),
                    ),
                    Text(
                      'Min side',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    RaisedButton(
                      color: customColors.osloDarkBlue,
                      child: Text(
                        'Logg ut',
                        style: TextStyle(color: customColors.osloWhite),
                      ),
                      onPressed: () async {
                        final bool result = await model.requestLogOut();
                        if (!result) {
                          uiHelper.showSnackbar(
                              context, 'Kunne ikke logge ut, prøv igjen.');
                        }
                      },
                    )
                  ],
                ),
              ),
              _aboutSection(model),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: _contactInfo()),
              _shareContactInfoSection(model),
              _addPartnerAndStationButtons(model, context),
            ],
          ),
        ),
      ),
    );
  }

  Text _subtitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _textWithIcon(String icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          customIcons.image(customIcons.person),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(title ?? 'N/A'),
          ),
        ],
      ),
    );
  }

  Widget _contactInfo() {
    Widget _withColor(Widget child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: Container(
          color: customColors.osloLightBlue,
          padding: EdgeInsets.all(4.0),
          child: child,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _subtitle('Min kontaktinfo'),
            CircleAvatar(
              backgroundColor: customColors.osloLightBlue,
              child: IconButton(
                onPressed: () => null,
                icon: customIcons.image(customIcons.editIcon),
              ),
            ),
          ],
        ),
        _withColor(_textWithIcon(customIcons.person, 'Fretex')),
        _withColor(_textWithIcon(customIcons.mobile, '91289312')),
        _withColor(_textWithIcon(customIcons.mail, 'fretex@gmail.com')),
        _withColor(Text('Ombrukskoordinator')),
      ],
    );
  }

  /// Only for the Partner role
  Widget _aboutSection(MyPageViewModel model) {
    if (model.role != globals.KeycloakRoles.partner) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _subtitle('Om Fretex'),
          Text(
              'Fretex skal bidra til at mennesker får og beholder arbeid. Fretex skal bidra til et bedre miljø gjennom blant annet gjenbruk og gjenvinning. Selskapets virksomhet skal drives i overensstemmelse med Frelsesarmeens verdigrunnlag.'),
        ],
      ),
    );
  }

  /// Only for the Partner role
  Widget _shareContactInfoSection(MyPageViewModel model) {
    if (model.role != globals.KeycloakRoles.partner) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _subtitle('Kontaktinformasjon'),
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
                    color: customColors.osloDarkBlue,
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
    );
  }

  /// Only for the REG role
  Widget _addPartnerAndStationButtons(
      MyPageViewModel model, BuildContext context) {
    if (model.role != globals.KeycloakRoles.reg_employee) {
      return Container();
    }

    Widget _buttonWithText(String text, Function onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: customColors.osloLightBeige,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(text),
                ),
                CircleAvatar(
                  backgroundColor: customColors.osloGreen,
                  child: customIcons.image(customIcons.add),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        _buttonWithText('Legg til ny samarbeidspartner', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPartneScreen(),
              ));
        }),
        _buttonWithText('Legg til ny stasjon', () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewStationScreen(),
              ));
        }),
      ],
    );
  }
}
