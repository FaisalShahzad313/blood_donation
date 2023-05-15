import 'package:cloud_firestore/cloud_firestore.dart';

class BloodRequest
{
  final String? id;
  final String? bloodGroup;
  final GeoPoint? location;
  final String? hospital;
  final String? message;
  final String? userId;
  final String? category;  // for which diseasse or patient
  final DateTime? requestedDate;
  final DateTime? dueDate;

  BloodRequest({this.id, this.bloodGroup, this.location, this.hospital, this.message, this.userId, this.category, this.requestedDate, this.dueDate, });

  factory BloodRequest.fromSnapshot( DocumentSnapshot snapshot)
  {
    return BloodRequest(
      id: snapshot.id,
      bloodGroup: snapshot['bloodGroup'],
  location: snapshot['location'],
  hospital: snapshot['hospital'],
      message: snapshot['message'],
      userId: snapshot['userId'],
      category: snapshot['category'],
      requestedDate: DateTime.fromMillisecondsSinceEpoch(snapshot['requestedDate']),
      dueDate: DateTime.fromMillisecondsSinceEpoch(snapshot['dueDate']),
    );
  }
  toSnapshot()
  {
    return{
      "bloodGroup": bloodGroup,
      "location": location,
      "hospital": hospital,
      "message": message,
      "userId": userId,
      "category": category,
      "requestedDate": DateTime.now().millisecondsSinceEpoch,
      "dueDate": DateTime.now().millisecondsSinceEpoch,
    };
  }
}