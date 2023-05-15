import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import '../widget/AppbottomBat.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(controller.currentIndex == 0 ? "Blood Donors" : controller.currentIndex == 1 ? "Donate Blood & Saves Lives" : "Settings"),
              backgroundColor: Colors.red,
              actions: [
                IconButton(
                    onPressed: (){

                    },
                    icon: const Icon(Icons.search)
                ),
              ],
            ),
            body:  controller.pages[controller.currentIndex],
            bottomNavigationBar: AppBottomBar(
              onTap: (int i) {
                controller.currentIndex = i;
              },
              currentIndex: controller.currentIndex,

            ),

          );
        }
    );
  }
}
