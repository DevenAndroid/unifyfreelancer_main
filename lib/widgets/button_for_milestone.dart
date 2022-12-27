import 'package:flutter/material.dart';

class NewButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const NewButton(
      {Key? key,
        required this.title,
        this.onPressed,
        required this.backgroundColor,
        this.textColor,
      })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xff6D2EF1),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                )),
            primary: backgroundColor,
           // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        onPressed: onPressed,
        child:  Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: textColor,
          ),
        ));
  }
}
