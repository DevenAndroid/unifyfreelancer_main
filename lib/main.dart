import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unifyfreelancer/resources/app_theme.dart';

import 'routers/my_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return GetMaterialApp(
          title: 'unify freelancer',
          debugShowCheckedModeBanner: false,
          // initialRoute: "/splash",
          getPages: MyRouter.route,

          theme: ThemeData(
              primarySwatch: primaryColorShades,
              fontFamily: 'Poppins',
          ),
        );
      },
    );
  }
}
