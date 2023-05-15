import 'dart:core';


import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
{
  final String? id;
  final String? imageUrl;
  final String? username;
  final String? phone;
  final String? email;
  final String? password;
  final DateTime? createdOn;
  final bool? isDonor;
  final GeoPoint? location;
  final String? bloodGroup;
  UserModel( {this.id, this.imageUrl, this.username, this.phone, this.email, this.password, this.createdOn,this.isDonor, this.location, this.bloodGroup, });

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot)
  {
    return UserModel(
        id: snapshot.id,
        imageUrl: snapshot['imageUrl'],
        username: snapshot['username'],
        phone: snapshot['phone'],
        email: snapshot['email'],
        password: snapshot['password'],
        createdOn: DateTime.fromMicrosecondsSinceEpoch(
            snapshot['createdOn']),
      isDonor: snapshot['isDonor'],
      location: snapshot['location'],
      bloodGroup: snapshot['bloodGroup'],
    );
  }
  // toSnapshot k zarye hm data base ko sara data send karye gy
    toSnapshot()
    {
      return{
        //"id": id,
        "imageUrl": imageUrl,
         "username":username,
        "phone":phone,
        "email":email,
        "password":password,
        "createdOn":createdOn!.millisecondsSinceEpoch,
        "isDonor" : isDonor,
        "location": location,
       // "bloodGroup" bloodGroup
      } ;
    }

}