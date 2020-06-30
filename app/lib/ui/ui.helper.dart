import 'package:flutter/material.dart';

class UIHelper {
  bool _loadingVisible = false;

  void showLoading(BuildContext context) {
    _loadingVisible = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              child: Center(
                child: Container(
                  width: 64.0,
                  height: 64.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            offset: Offset(0, 3),
                            blurRadius: 3.0,
                            spreadRadius: 0.0)
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void hideLoading(BuildContext context) {
    if (_loadingVisible) {
      _loadingVisible = false;
      Navigator.of(context).pop();
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Lukk',
        onPressed: () {},
      ),
    );

    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

UIHelper uiHelper = UIHelper();
