
import 'package:blood_donation/constants/appAssets.dart';
import 'package:blood_donation/controller/authController.dart';
import 'package:blood_donation/controller/controller.dart';
import 'package:blood_donation/views/DashBoardView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/bloodController.dart';
import 'loginView.dart';


class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  openAuthView() async
  {
    SharedPreferences shared = await SharedPreferences.getInstance();
    // agr is k ander userid hai to is ka matlab hai k user phly sy login hwa hwa hai
    String? userId = shared.getString("userId");
     Future.delayed(const Duration(seconds: 3), () {
       if(userId == null) {
         Get.off(() => const LoginView());
       }
       else
         {
           Get.off(() =>  DashboardView());
         }
     });

  }
  void startTimer() async
  {
    await Future.delayed(const Duration(seconds: 3), openAuthView );
  }
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent : true);
    Get.put(BloodController(), permanent : true);
    Get.put(DashboardController(), permanent : true);
    BloodController bloodController = Get.find();
    bloodController.getAllRequests();
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 300,),
          Center(
              child:SvgPicture.asset(AppAssets.appLogo, height:130)
              //Image(image: AssetImage("assets/images/blood-donation2.svg"), height: 200,)
          ),
          const SizedBox(height: 20,),
          const Text("Donate Blood To Save Lives "),
          const Text("With B Bank")
        ],
      ),

    );
  }
}