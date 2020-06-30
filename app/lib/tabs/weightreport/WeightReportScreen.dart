import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WeightReportScreen extends StatefulWidget {
  @override
  _WeightReportScreenState createState() => _WeightReportScreenState();
}

class _WeightReportScreenState extends State<WeightReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9C66B),
      
      body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      
      children: <Widget>[
        Text('Siste uttak'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.red[300],
                
              ),
              child: Text('Dato'),
              
              
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 0),
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                
              ),
              child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Vektuttak (kg)',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [BlacklistingTextInputFormatter(new RegExp('[\\-|\\ ]'))],
              )),
              RawMaterialButton(
                fillColor: Colors.red[300],
                child: Text('OK'), 
                onPressed: _submit,
                shape: CircleBorder())
          
        ]),
        Text('Tidligere uttak')
      ]));
  }
  void _submit (){

  }
}
