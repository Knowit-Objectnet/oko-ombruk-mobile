import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightReportDialog extends StatefulWidget {
  final Function(int newWeight) onSubmit;
  final int initialWeight;

  WeightReportDialog({@required this.onSubmit, this.initialWeight});

  _WeightReportDialogState createState() => _WeightReportDialogState();
}

class _WeightReportDialogState extends State<WeightReportDialog> {
  final TextEditingController _inputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _inputController.text = widget.initialWeight?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ny vekt (kg)'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _inputController,
          decoration: InputDecoration(hintText: 'Vektuttak (kg)'),
          style: TextStyle(fontSize: 12.0),
          keyboardType: TextInputType
              .number, // Decimal not allowed right now, may fix later
          inputFormatters: [
            // WhitelistingTextInputFormatter(
            // RegExp(r"^\d+\.?\d*$"))
            // ],
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) {
            if (value.isEmpty) {
              return 'Vennligst fyll ut noe';
            }
            final int number = int.tryParse(value.trim());
            if (number == null) {
              return 'Kun heltall er tillatt';
            }
            return null;
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Avbryt'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              final int newWeight = int.parse(_inputController.text.trim());
              widget.onSubmit(newWeight);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
