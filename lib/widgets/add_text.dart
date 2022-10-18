import 'package:flutter/material.dart';

import '../resources/app_theme.dart';
import '../resources/size.dart';

class AddText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final double? letterSpacing;
  final double? wordSpacing;
  final String? fontfamily;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? color;
  const AddText({
    Key? key,
    required this.text,
    this.fontSize = 0,
    this.fontWeight = FontWeight.w500,
    this.textAlign,
    this.textOverflow,
    this.decoration,
    this.color = Colors.black,
    this.height = 1,
    this.fontfamily,
    this.maxLines = 1,
    this.letterSpacing,
    this.wordSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      // maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
          color: color == Colors.black ? AppTheme.blackColor   : color,
          fontSize: fontSize == 0 ? AddSize.font14 : fontSize,
          decoration: decoration,
          height: height,
          letterSpacing: letterSpacing,
          fontFamily: fontfamily,
          wordSpacing: wordSpacing,
          fontWeight: fontWeight),
    );
  }
}
