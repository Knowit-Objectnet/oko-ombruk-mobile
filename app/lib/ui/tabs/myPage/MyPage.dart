import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ombruk/businessLogic/UserViewModel.dart';

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
    return Consumer<UserViewModel>(
      builder: (context, UserViewModel userViewModel, child) =>
          _MyPageConsumed(userViewModel),
    );
  }
}

class _MyPageConsumed extends StatefulWidget {
  final UserViewModel userViewModel;

  _MyPageConsumed(this.userViewModel);

  @override
  _MyPageConsumedState createState() => _MyPageConsumedState();
}

class _MyPageConsumedState extends State<_MyPageConsumed> {
  final EdgeInsets _verticalPadding = EdgeInsets.symmetric(vertical: 8.0);

  bool _showContactInfo = false; // TODO: Get this from data

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        Padding(
          padding: _verticalPadding,
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
                  final bool result =
                      await widget.userViewModel.requestLogOut();
                  if (!result) {
                    uiHelper.showSnackbar(
                        context, 'Kunne ikke logge ut, prøv igjen.');
                  }
                },
              )
            ],
          ),
        ),
        _aboutSection(),
        Padding(padding: _verticalPadding, child: _contactInfo()),
        _shareContactInfoSection(),
        _addPartnerAndStationButtons(),
      ],
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

  /// Only for the Partner role
  Widget _aboutSection() {
    if (widget.userViewModel.getRole() != globals.KeycloakRoles.partner) {
      return Container();
    }
    return Padding(
      padding: _verticalPadding,
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
  Widget _shareContactInfoSection() {
    if (widget.userViewModel.getRole() != globals.KeycloakRoles.partner) {
      return Container();
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: _verticalPadding,
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
          padding: _verticalPadding,
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
                activated: _showContactInfo,
                textOn: 'På',
                textOff: 'Av',
                buttonPressed: () {
                  setState(() {
                    _showContactInfo = !_showContactInfo;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Only for the REG role
  Widget _addPartnerAndStationButtons() {
    if (widget.userViewModel.getRole() != globals.KeycloakRoles.reg_employee) {
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
