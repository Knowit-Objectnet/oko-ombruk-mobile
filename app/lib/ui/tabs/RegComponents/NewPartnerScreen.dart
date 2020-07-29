import 'package:flutter/material.dart';

import 'package:ombruk/ui/customIcons.dart' as customIcons;
import 'package:ombruk/ui/customColors.dart' as customColors;

class NewPartneScreen extends StatefulWidget {
  @override
  _NewPartneScreenState createState() => _NewPartneScreenState();
}

class _NewPartneScreenState extends State<NewPartneScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _partnerNameController = TextEditingController();
  final _verticalPadding = EdgeInsets.symmetric(vertical: 8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColors.osloWhite,
        leading: IconButton(
          icon: customIcons.image(customIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ny samarbeidspartner',
          style: TextStyle(color: customColors.osloBlack),
        ),
      ),
      backgroundColor: customColors.osloLightBeige,
      body: GestureDetector(
        /// .unfocus() fixes a problem where the TextFormField isn't unfocused
        /// when the user taps outside the TextFormField.
        onTap: () => FocusScope.of(context).unfocus(),
        onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: _textInput(
                    'Navn på organisasjonen', _partnerNameController),
              ),
              Padding(
                padding: _verticalPadding,
                child: _uploadContractRow(),
              ),
              Padding(
                padding: _verticalPadding,
                child: RaisedButton(
                  onPressed: _submitForm,
                  color: customColors.osloGreen,
                  child: Text('Legg til samarbeidspartneren'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput(
    String hint,
    TextEditingController controller, {
    Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      decoration: BoxDecoration(
          color: customColors.osloWhite,
          border: borderColor != null
              ? Border.all(width: 2.0, color: borderColor)
              : null),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        validator: (value) {
          if (value.isEmpty) {
            return 'Vennligst fyll ut feltet';
          }
          return null;
        },
      ),
    );
  }

  Widget _uploadContractRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Last opp kontrakt'),
        RaisedButton(
          onPressed: () => null,
          color: customColors.osloLightBlue,
          child: Text('Bla gjennom filer'),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      // TODO
      return;
    }
  }
}
