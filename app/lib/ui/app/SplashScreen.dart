import 'package:flutter/material.dart';
import 'package:ombruk/ui/shared/const/CustomColors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ImageProvider backgroundImage = AssetImage("assets/reir.png");
    backgroundImage.resolve(createLocalImageConfiguration(context));
    return Scaffold(
      backgroundColor: CustomColors.osloDarkBlue,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(76, 202, 84, 0),
            child: Image(
              color: CustomColors.osloWhite,
              image: AssetImage("assets/reir.png"),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
