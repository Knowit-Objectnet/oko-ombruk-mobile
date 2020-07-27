import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ombruk/blocs/AuthenticationBloc.dart';

import 'package:ombruk/ui/tabs/components/SwitchButton.dart';

import 'package:ombruk/ui/customColors.dart' as customColors;
import 'package:ombruk/ui/customIcons.dart' as customIcons;

class MyPagePartners extends StatefulWidget {
  @override
  _MyPagePartnersState createState() => _MyPagePartnersState();
}

class _MyPagePartnersState extends State<MyPagePartners> {
  // TODO: Take as input a MyPageData class, or call the backend from here to fetch the data

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
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(AuthenticationLogOut());
                },
              )
            ],
          ),
        ),
        Padding(
          padding: _verticalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _subtitle('Om Fretex'),
              Text(
                  'Fretex skal bidra til at mennesker får og beholder arbeid. Fretex skal bidra til et bedre miljø gjennom blant annet gjenbruk og gjenvinning. Selskapets virksomhet skal drives i overensstemmelse med Frelsesarmeens verdigrunnlag.'),
            ],
          ),
        ),
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
        Padding(padding: _verticalPadding, child: _contactInfo())
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _subtitle('Min kontaktinfo'),
        _withColor(_textWithIcon(customIcons.person, 'name')),
        _withColor(_textWithIcon(customIcons.mobile, '91289312')),
        _withColor(_textWithIcon(customIcons.mail, 'bla@bla.com')),
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
}
