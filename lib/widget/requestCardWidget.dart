
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/appColor/appColor.dart';
import '../models/bloodRequestModel.dart';
import '../utils/common_function.dart';

class RequestCardWidget extends StatelessWidget {
  final BloodRequest request;
  const RequestCardWidget({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(10.sp),

      child: InkWell(
        onTap: (){

        },
        child: Container(
              height: 0.13.sh,
              width: 1.sw,
              decoration: BoxDecoration(

                color: Colors.blue,
              border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:  EdgeInsets.all(10.sp),
                    child: CircleAvatar(
                      radius: 30.r,
                      child: Text("${request.bloodGroup}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(

                        children: [
                          Text("Multan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                          SizedBox(width: 5.sp,),
                          const Icon(Icons.access_time),
                          SizedBox(width: 5.w,),
                          Text("Need on: ${CommonFunctions.formateDate(request.dueDate!)}"),
                        ],
                      ),
                      Row(
                        children: [

                          Icon(Icons.category),
                          SizedBox(width: 10.w,),
                          Text("${request.category}")
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.hotel),
                          SizedBox(width: 10.w,),
                          Text("${request.hospital}")

                        ],
                      ),
                      Row(
                        children: [

                          Icon(Icons.location_on),
                          Text("${request.location}")
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_outlined)
                ],
              ),
            ),
      )

      );

  }
}
