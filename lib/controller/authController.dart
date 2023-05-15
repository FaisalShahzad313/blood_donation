

import 'dart:io';

import 'package:blood_donation/models/models.dart';
import 'package:blood_donation/services/firebaseServices.dart';
import 'package:blood_donation/views/DashBoardView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebaseServices.dart';
import '../utils/common_function.dart';

class AuthController extends GetxController
{
  final emailController = TextEditingController();
  final passwardController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  bool _hidePassword = true;
  bool loading = false;
  String  imageUrl = "";
  String _bloodGroup = "Select blood Group";
  File? _image;
  GeoPoint _geoPoint = const GeoPoint(30.8012439, 73.361896);
  bool _isDonor = false;
  List<UserModel> _donors = [];

  //getters
  bool  get hidePassword => _hidePassword;
  File?  get image => _image;
  bool get isDonor => _isDonor;
  String get bloodGroup => _bloodGroup ;
  List<UserModel> get donors => _donors;

  //setters
  set bloodGroup(String val)
  {
    _bloodGroup = val;
    update();
  }
  set hidePassword(bool val )
  {
    _hidePassword = val;
    update();
  }
  set image(File? val)
  {
    _image = val;
    update();
  }
  set isDonor(bool val)
  {
    _isDonor = val;
    update();
  }
  signup() async
  {
    // yhan pr SharedPrefrences ka object create kya hai jis k ander user id store karwani hai
    // agr user id k ander kuch na kuch para hai to is ka matalab hai k user login hai agr khali hai to is ka matlab hai user login ni hai
    SharedPreferences shared = await SharedPreferences.getInstance();
    Position? position = await CommonFunctions.getCurrentPosition();
    // agr null ata hai to wo location save ho jaye gy jo ap ny by default rakhy hoi hai
    if(position != null)
    {
      _geoPoint = GeoPoint(position.latitude, position.longitude);
      // shared.setDouble jb hum ny request is k ander sy karwani ho gy to phr humy hy setDouble karna ho ga
      shared.setDouble("latitude", position.latitude);
      shared.setDouble("longitude", position.longitude);
    }
    else
    {
      shared.setDouble("latitude", _geoPoint.latitude);
      shared.setDouble("longitude", _geoPoint.longitude);
    }
    if(_validate())
    {
      loading= true;
      update();
      _uploadPhoto();
      var user = await FirebaseService.signupWithEmailAndPassword(email: emailController.text.trim(), password: passwardController.text.trim());
      if (user!= null)
      {
        //yh user id store karwa dy ga agr login ho gya ho t0
        shared.setString("userId", user.uid);
        // yahan pr hum isDonor ko sharedPrefrences k zarey store karwayen gy
        // "isDonor" yh naam hai             _isDonor is ko as a key bhejen gy
        //  is ko hum ny is lye store karwaya hai k jb hum ny setting k ander ja k setting change karni hai to wo sirf is ko change karn gi to setting change ho jaye gi
        shared.setBool("isDonor", _isDonor);
        UserModel userModel = UserModel(
            username:  usernameController.text.trim(),
            imageUrl: imageUrl,
            phone: phoneController.text.trim(),
            email:  emailController.text.trim(),
            password: passwardController.text.trim(),
            // createdOn ka yhan matlab hai k account kb bn rha hai     or jo dateTime.now ka matalab ha k jb account create ho ga us waqt ki date or time bataye ga
            createdOn: DateTime.now(),
            location: _geoPoint,
            isDonor: _isDonor,  // donor ko yhan pr kyun add kya hai
            bloodGroup : _isDonor == false ? "" :_bloodGroup
        );
        // user.uid ka mtlab hai k automatically id dena    is ko lagany ka maqsad yh hai k firebase k under documents ko apni marzy k  mutabiq id dy sakoo
        //
        FirebaseService.addUser(doc: userModel.toSnapshot(), userId: user.uid);
        // Get.offAll ka matlab hai k saray route band kr do
        // Get.off sy aik page band ho ga or Get.offAll sy sary page band hn gy
        Get.offAll(()=>DashboardView());
        loading = false;
        update();
      }
      else
      {
        loading = false;
        update();
      }
    }
  }


  login() async {
    // yhan pr SharedPrefrences ka object create kya hai jis k ander user id store karwani hai
    // agr user id k ander kuch na kuch para hai to is ka matalab hai k user login hai agr khali hai to is ka matlab hai user login ni hai
    SharedPreferences shared = await SharedPreferences.getInstance();
    if(_validateLogin())
    {
      Get.offAll(()=>DashboardView());
      loading= true;
      update();
      var user = await FirebaseService.logInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwardController.text.trim());
      if (user!= null)
      {
        shared.setString("userId", user.uid);
        loading = false;
        update();
      }
      else
      {
        loading = false;
        update();
      }
    }
  }

  resetPassword() async
  {
    if (_validateReset())
    {
      loading= true;
      update();
      await FirebaseService.sendResetPassword(email: emailController.text.trim(), password: passwardController.text.trim());
      loading =false;
      update();
    }
  }
  //only for sign up method
  bool _validate()
  {
    bool check = true;
    if (usernameController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Username Required","Please Enter Username");
    }
    else if (CommonFunctions.validateEmail(usernameController.text.trim()))
    {
      check = false;
      CommonFunctions. showSnackBar("Invalid Username","Please Enter valid Username Email is not accepted");
    }
    else if (emailController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Email Required","Please Enter Email");
    }
    else if (!CommonFunctions.validateEmail(emailController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Email ", "Please Enter your valid Email");
    }
    else if (passwardController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Password Required","Please Enter Password");
    }
    else if (!CommonFunctions.validatePassword(passwardController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Password ", "Password should contain a capital letter a number and at least 8 length");
    }
    else if(phoneController.text.trim().isEmpty)
    {
      check = false;
      CommonFunctions.showSnackBar("Phone Required", "Please enter your Phone Number");
    }
    else if (_isDonor == true && _bloodGroup == "Select Blood Group")
      {
        check = false;
        CommonFunctions.showSnackBar("Select Blood Group", "Please Select Blood Group");
      }
    else if(phoneController.text.trim().length!=11)
    {
      check = false;
      CommonFunctions.showSnackBar("Invalid Phone ", "Please enter your valid Phone Number");
    }


    return check;
  }

  // method for login
  bool _validateLogin()
  {
    bool check = true;
    if (emailController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Email Required","Please Enter Email");
    }
    else if (!CommonFunctions.validateEmail(emailController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Email ", "Please Enter your valid Email");
    }
    else if (passwardController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Password Required","Please Enter Password");
    }
    else if (!CommonFunctions.validatePassword(passwardController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Password ", "Password should contain a capital letter a number and at least 8 length");
    }
    return check;
  }
  bool _validateReset()
  {
    bool check = true;
    if (emailController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Email Required","Please Enter Email");
    }
    else if (!CommonFunctions.validateEmail(emailController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Email ", "Please Enter your valid Email");
    }
    else if (passwardController.text.trim().isEmpty)
    {
      check  = false;
      CommonFunctions. showSnackBar("Password Required","Please Enter Password");
    }
    else if (!CommonFunctions.validatePassword(passwardController.text.trim())) {
      check = false;
      CommonFunctions.showSnackBar("Invalid Password ", "Password should contain a capital letter a number and at least 8 length");
    }
    return check;
  }

  _uploadPhoto()async
  {
    loading = true;
    update();
    if (_image != null)
    {
      var url = await Future.wait({FirebaseService.uploadFile(_image!)});
      if(url.isNotEmpty)
      {
        imageUrl = url.first;
        update();
      }
    }

  }


  getAllDonner() async
  {
    var data = await FirebaseService.getDocuments(collection: "Users", where1:  "isDonners", where1Value: true);
    _donors = data.map((e) => UserModel.fromSnapshot(e)).toList();
    update();
  }
}