import 'package:blood_donation/constants/appColor/appColor.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const AppBottomBar({Key? key, required this.onTap, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: currentIndex,
      style: TabStyle.reactCircle,
      items: const [
        TabItem(icon: Icons.person_2, title:  "Donnors"),
        TabItem(icon: Icons.bloodtype, title:  "Request"),
        TabItem(icon: Icons.settings, title:  "Setting"),
      ],
      onTap: onTap,
      backgroundColor: AppColors.primaryColor,
    );
  }
}
