//
// import 'package:blood_donation/models/bloodRequestModel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../constants/appColor/appColor.dart';
//
// class RequestCardWidget extends StatelessWidget {
//   final BloodRequest request;
//   const RequestCardWidget({Key? key,  required this.request}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding:  EdgeInsets.all(10.sp),
//         child: Container(
//           height: 0.13.sh,
//           width: 1.sw,
//           decoration: BoxDecoration(
//               color: Colors.green,
//               border: Border.all(color: AppColors.primaryColor),
//               borderRadius: BorderRadius.circular(10)
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Padding(
//                 padding:  EdgeInsets.all(10.sp),
//                 child: CircleAvatar(
//                   radius: 30.r,
//                   child: Text("AB+"),
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//
//                     children: [
//                       Text("Multan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
//                       SizedBox(width: 30.sp,),
//                       Icon(Icons.access_time),
//                       SizedBox(width: 5.w,),
//                       Text("08-08-2023"),
//                     ],
//                   ),
//                   Row(
//                     children: [
//
//                       Icon(Icons.category),
//                       SizedBox(width: 10.w,),
//                       Text("Accidental Case")
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.hotel),
//                       SizedBox(width: 10.w,),
//                       Text("DHQ Okara")
//
//                     ],
//                   ),
//                   Row(
//                     children: [
//
//                       Icon(Icons.location_on),
//                       Text("djdhj3392ei38328djxn")
//                     ],
//                   )
//                 ],
//               ),
//               Icon(Icons.arrow_forward_ios_outlined)
//             ],
//           ),
//         )
//
//        );
//
//    }
// }