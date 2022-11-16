import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/app_theme.dart';
import '../resources/size.dart';

class CommonProgressIndicator extends StatelessWidget {
  const CommonProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Platform.isAndroid ? const CircularProgressIndicator(color: AppTheme.primaryColor,):
        CupertinoActivityIndicator(color: AppTheme.primaryColor,radius: AddSize.size18, )
    );
  }
}