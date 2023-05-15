
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bloodController.dart';
import '../widget/requestCard.dart';
import '../widget/requestCardWidget.dart';
import 'addRequestView.dart';

class ShowRequestsView extends StatelessWidget {
  const ShowRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: GetBuilder<BloodController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.request.length,
              itemBuilder: (context, index)
                  {
                    return RequestCardWidget(request: controller.request[index]);
                  }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Get.to(() => AddRequestView());
        },
      ),

    );
  }
}
