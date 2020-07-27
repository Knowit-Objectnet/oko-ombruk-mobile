import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ombruk/ui/ui.helper.dart';

class WeightReportDialog extends StatelessWidget {
  final Function(int newWeight) onSubmit;
  final int initialWeight;
  final TextEditingController _inputController = TextEditingController();

  WeightReportDialog({@required this.onSubmit, this.initialWeight}) {
    _inputController.text = initialWeight?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ny vekt (kg)'),
      content: TextField(
        controller: _inputController,
        decoration: InputDecoration(hintText: 'Vektuttak (kg)'),
        style: TextStyle(fontSize: 12.0),
        keyboardType: TextInputType
            .number, // Decimal not allowed right now, may fix later
        inputFormatters: [
          // WhitelistingTextInputFormatter(
          // RegExp(r"^\d+\.?\d*$"))
          // ],
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Avbryt'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            String value = _inputController.text;
            int newWeight = int.tryParse(value);
            if (newWeight == null) {
              uiHelper.showSnackbar(context, 'Bare heltall er tillatt');
            } else {
              onSubmit(newWeight);
            }
          },
        ),
      ],
    );
  }
}
