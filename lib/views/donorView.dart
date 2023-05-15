
import 'package:blood_donation/utils/common_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/authController.dart';

class DonnerView extends StatelessWidget {
  const DonnerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      GetBuilder<AuthController>(
          builder: (controller) {
            return ListView.builder(
                itemCount: controller.donors.length,
                padding:  EdgeInsets.all(8.w),
                itemBuilder: (context, index)
                {
                  return  Card(
                    child: ListTile(
                      tileColor:  Colors.red.shade50,
                     leading: CircleAvatar(
                       child: Text("${controller.donors[index].bloodGroup}"),
                     ),
                      title:  Text("${controller.donors[index].bloodGroup}"),
                      subtitle: FutureBuilder(
                        future: CommonFunctions.getAddressFromCordinates(controller.donors[index].location!.latitude, controller.donors[index].location!.longitude),
                        builder: (context , AsyncSnapshot<String> snapshot)
                          {
                            if(!snapshot.hasData)
                              {
                                return const SizedBox.shrink();

                              }
                            return Text("${snapshot.data}");
                          }
                      )
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
