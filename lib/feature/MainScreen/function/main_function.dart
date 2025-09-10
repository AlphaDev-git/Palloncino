

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pallon_app/models/user_model.dart';

Future<UserModel> GetUserData(String doc)async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  UserModel userModel=UserModel(doc: doc, email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  await for(var snap in firestore.collection('user').where('doc',isEqualTo: doc).snapshots()){
    userModel=UserModel(
        doc: doc, email: snap.docs[0].get('email'),
        phone: snap.docs[0].get('phone'), name: snap.docs[0].get('name'),
        pic: snap.docs[0].get('pic'), type: snap.docs[0].get('type'));
    return userModel;
  }
  return userModel;
}