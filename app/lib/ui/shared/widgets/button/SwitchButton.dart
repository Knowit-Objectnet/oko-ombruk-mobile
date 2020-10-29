import 'package:flutter/material.dart';

import 'package:ombruk/ui/shared/const/CustomColors.dart';

// Inspired from https://pub.dev/packages/custom_switch
class SwitchButton extends StatefulWidget {
  final bool activated;
  final String textOn;
  final String textOff;
  final Function buttonPressed;
  final Color color;

  SwitchButton({
    @required this.activated,
    @required this.textOn,
    @required this.textOff,
    @required this.buttonPressed,
    this.color = CustomColors.osloDarkBlue,
  })  : assert(activated != null),
        assert(textOn != null),
        assert(textOff != null),
        assert(buttonPressed != null);

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _circleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin:
                widget.activated ? Alignment.centerRight : Alignment.centerLeft,
            end:
                widget.activated ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_controller.isCompleted) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            widget.buttonPressed();
          },
          child: Column(
            // Column makes the widget width minimal
            children: <Widget>[
              Container(
                width: 70.0,
                height: 35.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: widget.color),
                  color: CustomColors.osloWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _circleAnimation.value == Alignment.centerRight
                          ? _onOffText(widget.textOn)
                          : Container(),
                      Align(
                        alignment: _circleAnimation.value,
                        child: Container(
                          width: 25.0,
                          height: 25.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: widget.color),
                        ),
                      ),
                      _circleAnimation.value == Alignment.centerLeft
                          ? _onOffText(widget.textOff)
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _onOffText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        text,
        style: TextStyle(
            color: widget.color, fontWeight: FontWeight.w900, fontSize: 16.0),
      ),
    );
  }
}
