import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CommonFunctions {
  static showSnackBar(String title, String message) {
    GetSnackBar snackBar = GetSnackBar(
      title: title,
      message: message,
      duration: const Duration(seconds: 2),

    );
    Get.showSnackbar(snackBar);
  }

  static Future<File?> pickImage() async
  {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    }
    else {
      return null;
    }

  }

static bool validateEmail(String email)
{
  final bool emailValid =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  return emailValid;
}
  static bool validatePassword(String value)
  {
    bool check = true;
    final bool passwordValid =  RegExp(r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value);

    return passwordValid;
  }

 // Position yhan pr return type hai

  static Future<Position?> getCurrentPosition() async
  {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar("Permission Denied", "Location Permission denied by user");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return null;

      }
    }
    else if (permission == LocationPermission.whileInUse || permission == LocationPermission.always)
   {
     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     print(position);
     return position;
   }
    return null;
  }

  static String formateDate(DateTime date)
  {
    return DateFormat("dd-MM-yyyy").format(date);
  }

  static Future<String> getAddressFromCordinates(double latitude, double longitude) async
  {
    String address = "";
    List<Placemark> placeMarks = await  placemarkFromCoordinates(latitude, longitude);
    if(placeMarks.isEmpty)
      {
        Placemark position = placeMarks.first;
        address = "${position.locality}, ${position.administrativeArea}";
        print(position);

      }
    return address;
  }
}
