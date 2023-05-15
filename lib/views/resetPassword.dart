import 'package:blood_donation/controller/authController.dart';
import 'package:blood_donation/views/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Constants/appAssets.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({Key? key}) : super(key: key);

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
                      decoration: InputDecoration(

                          prefixIcon: const Icon(Icons.email,),
                          labelText: "Enter Email/Phone Number",labelStyle: const TextStyle(),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),
                    const SizedBox(height: 25,),
                 /*   TextFormField(
                       //controller: controller.emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email,size: 35,),
                          labelText: "Enter Your Code",labelStyle: const TextStyle(fontSize: 20),

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),  */
                    //const SizedBox(height: 25,),
                    TextFormField(
                      controller: controller.passwardController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock,),
                          labelText: "New Password",labelStyle: const TextStyle(),

                          border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                     controller.loading ? const Center(child: CircularProgressIndicator(),):
                    ElevatedButton(
                        onPressed: ()
                        {
                         controller.resetPassword();
                        },
                        style: ButtonStyle(
                            //fixedSize: MaterialStateProperty.all(const Size(200.0,40))
                        ),
                        child: const Text("Reset Password",style: TextStyle(),)
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
