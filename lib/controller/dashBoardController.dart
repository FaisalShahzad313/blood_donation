
import 'package:blood_donation/views/requestViews.dart';
import 'package:blood_donation/views/signUp_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/addRequestView.dart';
import '../views/donorView.dart';
import '../views/setting.dart';

class DashboardController extends GetxController
{
  int _currentIndex = 0;
  int maxCount = 3;


  int get currentIndex => _currentIndex;


  set currentIndex(int val)
  {
    _currentIndex = val;
    update();
  }

  final List<Widget> pages = const [
    DonnerView(),
    ShowRequestsView(),
    //SettingView()
  ];



}