
import 'package:blood_donation/widget/requestCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bloodController.dart';
import '../widget/requestCard.dart';

class ShowRequestsView extends StatelessWidget {
  const ShowRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: GetBuilder<BloodController>(
            builder: (controller) {
              return controller.loading ? const Center(child:  CircularProgressIndicator(backgroundColor: Colors.black,),):
               ListView.builder(
                  itemCount: controller.request.length,
                  itemBuilder: (context, index)
                  {
                    return RequestCardWidget(request: controller.request[index]);
                  }
              );
            }
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.add_circle),
      ),
        );
  }
}