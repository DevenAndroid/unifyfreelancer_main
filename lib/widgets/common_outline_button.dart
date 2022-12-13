import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool? expandedValue;
  final Color? textColor;

  const CustomOutlineButton(
      {Key? key,
      required this.title,
      this.onPressed,
      required this.backgroundColor,
      this.textColor,
      this.expandedValue = false})
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
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        onPressed: onPressed,
        child: expandedValue == true
            ? SizedBox(
                width: double.maxFinite,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: textColor,
                    ),
                  ),
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                  color: textColor,
                ),
              ));
  }
}
