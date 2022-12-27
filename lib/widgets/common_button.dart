import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String buttonText;
  VoidCallback function;
  double buttonWidth; // add this
  double buttonHeight; // add this
  CommonButton(this.buttonText, this.function, this.buttonWidth,
      this.buttonHeight); // change this

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [
            Color(0xfff2bde2),
            Color(0xffa39ef5),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: MaterialButton(

        minWidth: buttonWidth,
        height: buttonHeight,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: function, // add this here
        child: Text(buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16)
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}