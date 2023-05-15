
import 'package:blood_donation/controller/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/appAssets.dart';
import '../widget/select_image.dart';
import 'loginView.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace:  Container(
          height: 0.30.sh,
          width: 1.sw,
          //color: Colors.red,
          decoration: BoxDecoration(
              image: const DecorationImage(
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
            child: Column(
              children: [

                const Center(child: Text("BLOOD DONATION",style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.w500,),)),

                        SelectImage(
                          onSelect: (file){
                              controller.image = file;
                          },
                          imageUrl: controller.imageUrl,
                        ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person,),
                        labelText: "User Name",labelStyle: const TextStyle(),

                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 13,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email,),
                        labelText: "Email",labelStyle: const TextStyle(),

                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: controller.passwardController,
                    obscureText: controller.hidePassword,
                    decoration: InputDecoration(
                        prefixIcon:  const Icon(Icons.lock,),
                        labelText: "Password",labelStyle: const TextStyle(),
                          fillColor: Colors.redAccent,

                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15)
                        ),

                      suffixIcon: IconButton(
                        onPressed: (){
                          controller.hidePassword = !controller.hidePassword;
                        },
                        splashRadius: 20.w,
                        icon: Icon(controller.hidePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),

                  ),
                ),
                const SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 11,

                    controller: controller.phoneController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone,),
                        labelText: "Phone Number",labelStyle: const TextStyle(),

                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Are you blood donor?", style: TextStyle(fontWeight:FontWeight.w600),),
                      Switch(
                          value: controller.isDonor,
                          onChanged: (val){
                            controller.isDonor = !controller.isDonor;
                            // null check operator lagany ka maqsad yh hai k agr true hai to false ho jaye or agr false hai to true ho jaye
                          }
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                controller.loading? const Center(child: CircularProgressIndicator(),):
                ElevatedButton(
                    onPressed: ()
                    {
                      controller.signup();
                    },
                    style: const ButtonStyle(
                        //fixedSize: MaterialStateProperty.all(const Size(200.0,50))
                    ),
                    child: const Text("Sign Up",style: TextStyle(),)
                ),
                const SizedBox(height: 0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account ?"),
                    TextButton(
                        onPressed: ()
                        {
                          Get.off(()=> const LoginView());

                        },
                        style: const ButtonStyle(
                            //fixedSize: MaterialStateProperty.all(const Size(600.0,50))
                        ),
                        child: const Text(" Sign In",style: TextStyle(),)
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
