import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/setting_controller.dart';

class SettingView extends StatelessWidget {
 const  SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
     body: GetBuilder<SettingController>(
       builder: (controller) {
         return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.maxFinite,
                height: 200.h,
                color: controller.isDonor ? Colors.red : Colors.green,
                child:  Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children:  const [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.lightGreenAccent,
                        child: Icon(Icons.person_rounded, size: 30, color: Colors.grey,),
                      ),
                      SizedBox(width: 23,),
                      Text("Faisal", style: TextStyle(fontSize: 22,color: Colors.white),),
                    ],
                  ),
                ),
              ),

              Center(
                child: Container(
                  height: 55,
                  width: 370,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListTile(
                    leading: const Text("Donors"),
                    trailing: Switch(
                      activeColor: Colors.green,
                      value: controller.isDonor,
                      onChanged: (bool value) {
                        controller.isDonor = !controller.isDonor;
                        controller.update();
                      }
                    ),
                  ),
                ),
              ),

              const Text("Requests",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),),
              const SizedBox(height: 13,),
              const ListTile(
                leading: Icon(Icons.photo_library,size: 25,),
                title: Text("Manage Request", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const Text("General",style: TextStyle(fontSize: 26,fontWeight: FontWeight.w500),),
              const SizedBox(height: 13,),
              const ListTile(
                leading: Icon(Icons.person_outlined,size: 25,),
                title: Text("My Profile", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.share,size: 25,),
                title: Text("Share App", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.star_rate_rounded,size: 25,),
                title: Text("Manage Request", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.feedback,size: 25,),
                title: Text("Feedback & Suggestions", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.privacy_tip,size: 25,),
                title: Text("Privacy", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
              const ListTile(
                leading: Icon(Icons.logout,size: 25,),
                title: Text("Logout", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          );
       }
     )
    );
  }
}
