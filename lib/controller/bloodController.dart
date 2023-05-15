
import 'dart:async';

import 'package:blood_donation/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebaseServices.dart';
import '../utils/common_function.dart';

class BloodController extends GetxController
{
  // controller ki madad sy hum map ko control karyn gy
  // Completer ek data type hai yh bhi async hi hai
  final Completer<GoogleMapController> mapController = Completer();
   String _bloodGroup = "Enter Your Blood Group";
   String _category ="Select Category";
   final List<String> bloodGroups = ['A+','B+','AB+','O+','A-','B-','AB-','0-',];
   final List<String> typeOfCategory = ['Accidental Case', 'Delivery Case', 'Surgical Operation'];
  final addressController = TextEditingController();
  final dueDateController = TextEditingController();
  final messageController = TextEditingController();
  bool loading = false;
  DateTime _dueDate = DateTime.now();
  // geoPoint ka private variable bnaya hai or is main   by default okara ki position rakhi hai
  // is main by  default okara ki position is lye  rakhi  hai  ta k  yh null na rahay
  GeoPoint _geoPoint = const GeoPoint(30.8012439, 73.361896);
  List<UserModel> _donors = [];
  List<BloodRequest> _request = [];




  String get bloodGroup => _bloodGroup;
  String get category => _category;
  DateTime get dueDate => _dueDate;
  GeoPoint get geoPoint => _geoPoint;
  List<UserModel> get donors => _donors;
  List<BloodRequest>  get request => _request;
// geo point ki madad sy map k uper sy location set karwaye gy
set geoPoint(GeoPoint val)
{
  _geoPoint = val;
  update();
}
  set bloodGroup (String val)
  {
    _bloodGroup = val;
    update();
  }
  set category (String val)
  {
    _category = val;
    update();
  }
  set dueDate(DateTime val)
  {
    _dueDate = val;
    dueDateController.text = CommonFunctions.formateDate(val);
    update();
  }


  bool _validate()
  {
    bool check = false;
    if(addressController.text.isEmpty)
    {
      CommonFunctions.showSnackBar("Hospital Address Not Entered", "Please Enter Hospital Address to Add your Request.");
    }
    else if(dueDateController.text.isEmpty)
    {
      CommonFunctions.showSnackBar("Due Date Not Entered", "Please Select Due date to add your request.");
    }
    else if(messageController.text.isEmpty)
    {
      CommonFunctions.showSnackBar("Message Is Not Entered", "Please Enter a Message for the Donner to Add your Request");
    }
    else if(bloodGroup.isEmpty)
    {
      CommonFunctions.showSnackBar("Select Blood Group", "Select Your Blood Group to Add your Request.");
    }
    else if(category.isEmpty)
    {
      CommonFunctions.showSnackBar("Select Category", "Select Your Category to Add your Request.");
    }
    return check;
  }
  saveRequest() async
  {

    SharedPreferences shared = await SharedPreferences.getInstance();
    String? userId = shared.getString("userId");
    if(_validate())
    {
      loading = true;
      update();
      BloodRequest request = BloodRequest(
          bloodGroup: _bloodGroup,
          category: _category,
          location: _geoPoint,
          hospital: addressController.text.trim(),
          message: messageController.text.trim(),
          userId: userId.toString(),
          requestedDate: DateTime.now(),
          dueDate: _dueDate
      );

      await FirebaseService.add(collection: "BloodRequests", doc: request.toSnapshot());
      _bloodGroup ="Select Your Blood Group";
      _category = "Select Request Category";
      addressController.clear();
      messageController.clear();
      dueDate = DateTime.now();
      await getAllRequests();
      loading = false;
      loading = false;
      update();
      CommonFunctions.showSnackBar("Request Sent", "Your Request has been Added.");
    }
  }

  CameraPosition cameraPosition = const CameraPosition(
      target: LatLng(30.8012439, 73.361896),
      zoom: 14.4746
  );
  @override
  onInit()
  {
    super.onInit();
    _getCurrentLocation();
  }
  _getCurrentLocation()async
  {
    Position? position =  await CommonFunctions.getCurrentPosition();
    if (position != null)
      {
        _geoPoint =  GeoPoint(position.latitude, position.longitude);
        CameraPosition cameraPosition =  CameraPosition(
            target: LatLng(position.latitude, position.longitude),
                zoom: 14.4746
        );
      }
  }

  getAllRequests() async
  {
    loading = true;
    var data = await FirebaseService.getDocuments(collection: "Blood Requests");
    _request = data.map((e) => BloodRequest.fromSnapshot(e)).toList();
    _request.sort((a,b) => b.requestedDate!.compareTo(a.requestedDate!));
    loading=false;
    update();
  }
  setCurrentPosition(LatLng val)
  {
    _geoPoint = GeoPoint(val.latitude,val.longitude);
    update();
  }
}