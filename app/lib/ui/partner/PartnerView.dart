import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';
import 'package:ombruk/ui/shared/const/CustomIcons.dart';

class PartnerView extends StatelessWidget {
  final EdgeInsets _verticalPadding = EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: <Widget>[
        Padding(
          padding: _verticalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _subtitle('Om Frigo'),
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
          child: _mainContact(
              name: 'Navn',
              phone: '+47 92738492',
              email: 'example@example.com'),
        ),
        Padding(
          padding: _verticalPadding,
          child: _chauffeur(
            name: 'Navn',
            phone: '+47 92738492',
          ),
        ),
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

  Column _mainContact({
    @required String name,
    @required String phone,
    @required String email,
    String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _subtitle('Hovedkontakt'),
        Container(
          padding: EdgeInsets.all(8.0),
          color: CustomColors.osloLightBeige,
          child: Column(
            children: <Widget>[
              _textWithIcon(CustomIcons.person, name),
              _textWithIcon(CustomIcons.mobile, phone),
              _textWithIcon(CustomIcons.mail, email),
              description != null ? Text(description) : Container(),
            ],
          ),
        )
      ],
    );
  }

  Column _chauffeur({@required String name, @required String phone}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _subtitle('Sjåfør'),
        Container(
          padding: EdgeInsets.all(8.0),
          color: CustomColors.osloLightBeige,
          child: Column(
            children: <Widget>[
              _textWithIcon(CustomIcons.person, name),
              _textWithIcon(CustomIcons.mobile, phone),
            ],
          ),
        )
      ],
    );
  }

  Widget _textWithIcon(String icon, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: <Widget>[
          CustomIcons.image(CustomIcons.person),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(title ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
