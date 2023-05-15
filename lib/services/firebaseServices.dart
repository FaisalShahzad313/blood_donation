import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/common_function.dart';

class FirebaseService
{
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<User?> signupWithEmailAndPassword({  required email, required password}) async
  {
    try
    {
      UserCredential credential  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      user!.sendEmailVerification();
      CommonFunctions.showSnackBar("Error", "A verification email sent to");
      return user;
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == "email-already-in-use")
      {
        CommonFunctions.showSnackBar("Error", "email already exists. use different email");
      }
      else if(e.code == "invalid-email")
      {
        CommonFunctions.showSnackBar( "Error","Please enter valid email");
      }
      else if(e.code == "operation-not-allowed")
      {
        CommonFunctions.showSnackBar("Error", "Operation Not Allowed. Please Enter Email Authentication");

      }
      else if(e.code == "weak-password")
      {
        CommonFunctions.showSnackBar( "Error","Password too weak, Enter Strong Password");

      }
      return null;

    }
  }
  static Future<User?> logInWithEmailAndPassword({ required email, required password}) async
  {
    try
    {
      UserCredential credential  = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return user;
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == "user-not-found")
      {
        CommonFunctions.showSnackBar("Error", "User not found. Please signUp firstly");
      }
      else if(e.code == "invalid-email")
      {
        CommonFunctions.showSnackBar( "Error","Please enter valid email");
      }
      else if(e.code == "user-disabled")
      {
        CommonFunctions.showSnackBar( "Error","User Account Disabled by Admin");

      }
      else if(e.code == "wrong-password")
      {
        CommonFunctions.showSnackBar( "Error","Wrong Password , Enter Correct Password");

      }
      return null;

    }
  }
  static sendCodeToPhoneNumber({ required String phone, required Function(String) onVerify}) async
  {
   try
       {
         _auth.verifyPhoneNumber(
             verificationCompleted: (val){},
             verificationFailed: (val){
               CommonFunctions.showSnackBar("Error", val.message.toString());
             },
             codeSent:( verifyId,resendToken)
             {
               onVerify(verifyId);
             },

             codeAutoRetrievalTimeout: (val){

             },
           phoneNumber: phone
         );
       }
       on FirebaseAuthException catch(e){
     CommonFunctions.showSnackBar("Error", e.message.toString());
       }
  }

  static Future<User?> logInWithPhoneNumber({ required PhoneAuthCredential credential, }) async
  {
    try
        {
         final userCredential = await _auth.signInWithCredential(credential);
         return userCredential.user;
        }
        on FirebaseAuthException catch(e)
   {
     if(e.code == "account-exists-with-different-credential")
     {
       CommonFunctions.showSnackBar( "Error","This account already exists try with another Number");
     }
     if(e.code == "invalid-credential")
     {
       CommonFunctions.showSnackBar( "Error","Invalid Number, Please enter a valid Number");
     }
     if(e.code == "operation-not-allowed")
     {
       CommonFunctions.showSnackBar("Error", "Operation Not Allowed");
     }
     if(e.code == "user-disabled")
     {
       CommonFunctions.showSnackBar( "Error","The admin has disabled this number.");
     }
     if(e.code == "invalid-verification-code")
     {
       CommonFunctions.showSnackBar( "Error","The verification code is invalid, Please enter a valid.");
     }
     if(e.code == "invalid-verification-id")
     {
       CommonFunctions.showSnackBar( "Error","This Id is Invalid, Please enter a valid ID.");
     }
      CommonFunctions.showSnackBar("Error", e.message.toString());
      return null;
    }
  }
  static signInWithGoogle({ required AuthCredential credential}) async
  {
    try
    {
      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    }
    on FirebaseAuthException catch(e)
    {
      if(e.code == "account-exists-with-different-credential")
      {
        CommonFunctions.showSnackBar( "Error","This account already exists try with another Number");
      }
      if(e.code == "invalid-credential")
      {
        CommonFunctions.showSnackBar( "Error","Invalid Number, Please enter a valid Number");
      }
      if(e.code == "operation-not-allowed")
      {
        CommonFunctions.showSnackBar( "Error","Operation Not Allowed");
      }
      if(e.code == "user-disabled")
      {
        CommonFunctions.showSnackBar("Error", "The admin has disabled this number.");
      }
      if(e.code == "invalid-verification-code")
      {
        CommonFunctions.showSnackBar( "Error","The verification code is invalid, Please enter a valid.");
      }
      if(e.code == "invalid-verification-id")
      {
        CommonFunctions.showSnackBar( "Error","This Id is Invalid, Please enter a valid ID.");
      }


      CommonFunctions.showSnackBar("Error", e.message.toString());
      return null;
    }

  }
  static  sendResetPassword({required String email, required  password})
  async {
    try
        {
          await _auth.sendPasswordResetEmail(email: email);

        }
        on FirebaseAuthException catch(e)
    {
      if(e.code == "auth/user-not-found"){
        CommonFunctions.showSnackBar("Error", "User not found");
      }
    }
  }
// is functio ki madad sy wo userModel ka sara data utaey  or phr firebase k ander collection bhi create kary  or documents bhe create kary or agr document phly sy bna hwa hai to us ko update kary
// is function ki madad sy jb wo firebase sy email ki madad sy login kary ga
  static addUser({required Map<String, dynamic> doc, required String userId}) async
  {
    try
    {
      // .doc(userId).set(doc)  <= is function ki madad sy model ka sara data documents ka ander dall dy ga agr collection ni bany hui to automatically collection ko create kary ga
      await FirebaseFirestore.instance.collection("User").doc(userId).set(doc);
    }
    on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", e.message.toString());
    }
  }
  // upper waly function ki id humy email ki madad sy pata chaly gi
  // agr kisi function ki id humy maloom ni hai to us ko add karny k lye is function ka istmaal karyn gy
  // required String collection,   collection   ko parameter  main is lye pass kia hai jis ko jis collection main add karna hai usi ka us ko naam dyn gy to wo usi collection main add ho jaye gi
  static add({required String collection,required Map<String, dynamic> doc, }) async
  {
    try
    {
      await FirebaseFirestore.instance.collection(collection).add(doc);
    }
    on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", e.message.toString());
    }
  }
  // is function main docId jo parameter main hai or jo neechy hai wo update karny k lye istmaal ho gy
// for update
  static update({required String collection,required Map<String, dynamic> doc, required String docId}) async
  {
    try
    {
      await FirebaseFirestore.instance.collection(collection).doc(docId).update(doc);
    }
    on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", e.message.toString());
    }
  }

// delete waly function k inder hum ny data bhejna ni hota is lye hum ko required Map<String, dynamic> doc, ki zaroorat ni hoty
  static delete({required String collection, required String docId}) async
  {
    try
    {
      await FirebaseFirestore.instance.collection(collection).doc(docId).delete();
    }
    on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", e.message.toString());
    }
  }

  // yh function only one document ly k aye ga
  //yh document jo hai user ka data nikalny  k lye istamaal ho ga
  // data/document jo hai snapshot k under wapis aye ga

  static Future<DocumentSnapshot<Map<String, dynamic>>?> getOneDocId({required String collection, required String docId }) async
  {
    // try cash ka matlab yh k jb bhi koi error a jaye to app crash na kary blky error bta dy
    try
        {
          // DocumentSnapshot wapis aye ga wapis // Future main data aye ga wapis  or Futrue main document snapshot aye ga wapis
          DocumentSnapshot<Map<String, dynamic>> data   = await FirebaseFirestore.instance.collection(collection).doc(docId).get();
          if(data.exists)
            {
              return data;
            }
           else
             {
               return null;
             }

        }
        on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", e.message.toString());
    }
    return null;
  }

 // yh function jo hai  blood donation or donors ki request ko get karny k lye use ho ga
 // filter ka matalb condition agr condition lagani hain to or parameter add karny pary gy where or us ki values agr poori collection ko uthana hai to yahan tk hi theek hai
  static Future<List<QueryDocumentSnapshot<Object?>>> getDocuments({required String collection, String? where1,  dynamic where1Value, where2,  dynamic where2Value })async
  {
    // collection k ander jb koi khali document aye
    List<QueryDocumentSnapshot<Object?>> list = [];
    //get data on two conditions
  if(where1 !=  null && where1Value != null && where2 != null && where2Value != null)
    {
      var data = await FirebaseFirestore.instance.collection(collection)
      // is equal to ka matalab hai k exactly match kary
          .where(where1, isEqualTo: where1Value)
          .where(where2, isGreaterThanOrEqualTo: where2Value)
      //8 bit k ander sari language support karti hain uf8 ka matab hai Universal Text Formatting
      // uf8ff age kisi bhi code k ander likha hwa hai to is ka matalab hai k hum is ko searchable rakhna cha rhey hain
          .where(where2, isLessThanOrEqualTo: "$where2Value\uf8ff")
      // .get ka ander yh sary document get kr ly ga
          .get();
      list = data.docs;
    }
  // get data on 1 condition
    else if(where1 !=  null && where1Value != null )
      {
        var data = await FirebaseFirestore.instance.collection(collection)

            .where(where1, isEqualTo: where1Value)

            .get();
        list = data.docs;
      }
    // is function k ander hum ny tri catch istmaal ni kya  kyn k hum hum ny list initially empty rkhy hwi  hai
  else
  {
    var data = await FirebaseFirestore.instance.collection(collection).get();
    list = data.docs;
  }
     return list;
  }




  static Future<String> uploadFile(File file) async
  {
    String  imageUrl = "";
    String fileName = path.basename(file.path);
    try
        {
          Reference reference =FirebaseStorage.instance.ref().child(fileName);
          UploadTask uploadTask = reference.putFile(file);
          TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
          imageUrl = await reference.getDownloadURL();
        }
        on FirebaseException catch(e)
    {
      CommonFunctions.showSnackBar("Error", "${e.message}");
    }
    return imageUrl;
  }
}