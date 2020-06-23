import 'package:flutter/material.dart';

class ExtraHentingDialog extends StatefulWidget {
  @override
  _ExtraHentingDialogState createState() => _ExtraHentingDialogState();
}

class _ExtraHentingDialogState extends State<ExtraHentingDialog> {
  final whoController = TextEditingController();
  final whatController = TextEditingController();

  @override
  void dispose() {
    whoController.dispose();
    whatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Søk om ekstra henting',
                      style: TextStyle(fontSize: 20.0))),
              IconButton(icon: Icon(Icons.close), onPressed: _closeDialog)
            ],
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              )),
          Text('date'),
          Text('place'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text('Hvem skal hente?'),
              ),
              Flexible(
                  flex: 1,
                  child: TextField(
                      controller: whoController,
                      decoration:
                          InputDecoration(hintText: 'Hvem skal hente?'))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Text('Hva skal hentes?'),
              ),
              Flexible(
                  flex: 1,
                  child: TextField(
                      controller: whatController,
                      decoration:
                          InputDecoration(hintText: 'Hva skal hentes?'))),
            ],
          ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                  onPressed: _closeDialog,
                  color: Colors.red,
                  child: Text('Avbryt')),
              FlatButton(
                  onPressed: _submitDialog,
                  color: Colors.green,
                  child: Text('Søk'))
            ],
          )
        ],
      ),
    );
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }

  void _submitDialog() {
    print("Submit");
  }
}
