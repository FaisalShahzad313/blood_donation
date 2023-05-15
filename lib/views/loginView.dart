import 'package:blood_donation/controller/authController.dart';
import 'package:blood_donation/views/resetPassword.dart';
import 'package:blood_donation/views/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Constants/appAssets.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace:   Container(
          height: 0.30.sh,
          width: 1.sw,
          //color: Colors.red,
          decoration: BoxDecoration(
              image:  DecorationImage(
                image:   AssetImage(AppAssets.clots),
                fit:BoxFit.cover,

              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(120.w, 50.h),bottomRight: Radius.elliptical(120.w, 50.h))
          ),
        ),
        toolbarHeight: 0.18.sh,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark
        ),
      ),

      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  const Text("BLOOD DONATION",style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.w500),),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email,),
                      labelText: "Email",labelStyle: const TextStyle(),

                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(15)
                       )
                    ),
                  ),
                  const SizedBox(height: 25,),
                  TextFormField(
                    obscureText:controller.hidePassword  ,
                    keyboardType: TextInputType.text,
                    controller: controller.passwardController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,),
                        labelText: "Password",labelStyle: const TextStyle(),
                      suffixIcon: IconButton(
                        onPressed: (){
                          controller.hidePassword = !controller.hidePassword;
                        },
                        splashRadius: 20.w,
                        icon: Icon(controller.hidePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15)
                        ),

                    ),
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){
                          Get.off(()=>ResetPassword());
                        },
                        style: ButtonStyle(

                          //backgroundColor: MaterialStateProperty.all(Colors.yellow),
                          foregroundColor: MaterialStateProperty.all(Colors.red),

                        ),
                        child: const Text("ForgotPassword?",style: TextStyle(),)),
                  ),
                  const SizedBox(height: 20,),
                  controller.loading ? const Center(child: CircularProgressIndicator(),):
                  ElevatedButton(
                      onPressed: ()
                      {
                       controller.login();
                      },
                      style: ButtonStyle(
                       // fixedSize: MaterialStateProperty.all(const Size(200.0,40))
                      ),
                      child: const Text("Login",style: TextStyle(),)
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have a Account?"),
                      TextButton(
                          onPressed: ()
                          {
                            Get.to(()=>const SignUpView());
                          },
                          style: ButtonStyle(
                              //fixedSize: MaterialStateProperty.all(const Size(350.0,40))
                          ),
                          child: const Text(" Sign Up ",style: TextStyle(),)
                      ),
                    ],
                  ),

                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
