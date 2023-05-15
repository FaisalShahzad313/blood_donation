
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/appColor/appColor.dart';
import '../controller/bloodController.dart';
import '../widget/input_feild.dart';

class AddRequestView extends StatelessWidget {
  const AddRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Blood Request"),
        ),
        body: GetBuilder<BloodController>(
            builder: (controller) {
              return Padding(
                padding:  EdgeInsets.all(18.w),
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor, width: 1),

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ExpansionTile(
                          leading: Icon(Icons.bloodtype, color: AppColors.primaryColor,),
                          key: Key(controller.bloodGroup),
                          title: Text(controller.bloodGroup,style: TextStyle(color: AppColors.primaryColor),),
                          children:
                          controller.bloodGroups.map(
                                  (e) =>
                                  ListTile(title: Text(e), onTap: ()
                                  {
                                    controller.bloodGroup = e;
                                  },
                                  )
                          ).toList()

                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor, width: 1),

                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ExpansionTile(
                        leading: Icon(Icons.category, color: AppColors.primaryColor,),
                        key: Key(controller.category),
                        title: Text(controller.category,style: TextStyle(color: AppColors.primaryColor)),
                        children: controller.typeOfCategory.map((e) =>
                            ListTile(title: Text(e),
                              onTap: (){
                                controller.category = e;
                              },
                            )
                        ).toList(),

                      ),
                    ),
                    SizedBox(height: 10.h,),
                    InputFieldWidget(
                      hintText: "Enter Hospital Address",
                      labelText: "Hospital Address",
                      controller: controller.addressController,
                      leading: const Icon(Icons.location_city_rounded),
                    ),
                    SizedBox(height: 10.h,),
                    InputFieldWidget(
                      hintText: "Enter Due Date Here",
                      labelText: "Due Date",
                      controller: controller.dueDateController,
                      readOnly: true,
                      leading: const Icon(Icons.calendar_month),
                      onTap: ()async{

                        Future<void> _showDatePicker(BuildContext context)async
                        {
                          DateTime? date = await showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900), lastDate: DateTime(2200));
                          if(date != null)
                          {
                            // controller.selectedDate = date;
                            controller.dueDateController.text = "${date.day}-${date.month}-${date.year}";
                          }
                        }
                        await _showDatePicker(context);

                      },
                    ),
                    SizedBox(height: 10.h,),
                    InputFieldWidget(
                      hintText: "Enter Your Message Here",
                      labelText: "Message",
                      controller: controller.messageController,
                      maxLines: 1,
                      keyboardType:TextInputType.multiline ,
                      leading: const Icon(Icons.message,color: Colors.red,),
                    ),
                    // 31:54 audio  of google maps
                    SizedBox(height: 10.h),
                    Container(
                      width: 1.sw,
                      height:  150.h,
                      decoration:  BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(8.w),
                      ),

                      child:  GoogleMap(
                        initialCameraPosition: controller.cameraPosition,
                        onMapCreated: (con)
                        {
                          controller.mapController.complete(con);
                        },
                        mapType: MapType.terrain,
                        markers: <Marker>{
                          Marker(
                              markerId: const MarkerId('current_position'),
                              position: LatLng(controller.geoPoint.latitude, controller.geoPoint.longitude)
                          )
                        },
                        onTap: (val)
                        {
                          controller.setCurrentPosition(val);
                        },
                       // zoomControlsEnabled: false,
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    ElevatedButton(
                        onPressed: ()
                        {
                         controller.saveRequest();
                        },
                        child: const Text("Add Request")
                    ),
                  ],
                ),
              );
            }
            ),
        );
    }
}