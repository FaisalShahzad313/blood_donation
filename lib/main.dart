import 'package:blood_donation/controller/authController.dart';
import 'package:blood_donation/controller/bloodController.dart';
import 'package:blood_donation/controller/controller.dart';
import 'package:blood_donation/firebase_options.dart';
import 'package:blood_donation/views/DashBoardView.dart';
import 'package:blood_donation/views/addRequestView.dart';
import 'package:blood_donation/views/donorView.dart';
import 'package:blood_donation/views/requestViews.dart';
import 'package:blood_donation/views/setting.dart';
import 'package:blood_donation/views/splash_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/dashBoardController.dart';

void main()async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));

WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options : DefaultFirebaseOptions.currentPlatform
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return ScreenUtilInit(
        designSize: const Size(360, 670),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Blood Donation App',
            debugShowCheckedModeBanner: false,
            initialBinding: InitialBiniding(),
            theme: ThemeData(
              textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
                bodyText2: GoogleFonts.roboto(textStyle: textTheme.bodyText2),
              ),

              primarySwatch: Colors.red,
            ),
            home:  SettingView(),
          );
        }
    );
  }
}


class InitialBiniding implements Bindings
{
  @override
  void dependencies(){
   Get.lazyPut(() =>AuthController(), fenix: true);
   Get.lazyPut(() =>BloodController(), fenix: true);
   Get.lazyPut(() =>DashboardController(), fenix: true);
   Get.lazyPut(() =>SettingController(), fenix: true);
  }
}

// agr hum main.dart k ander Get.lazyPut k ander koi bhi controller ni lagaye gy to null check operator ka error a jaye ga