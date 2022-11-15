import 'package:flutter/material.dart';

import '../resources/size.dart';
import 'add_text.dart';

class CommonErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback onTap;
  const CommonErrorWidget({Key? key, required this.errorText, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddText(
            text: errorText,
            textAlign: TextAlign.center,
            fontSize: AddSize.font16,
            fontWeight: FontWeight.w500,
          ),
          IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.change_circle_outlined,
                size: AddSize.size30,
              ))
        ],
      ),
    );
  }
}
