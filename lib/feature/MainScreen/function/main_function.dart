

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pallon_app/models/user_model.dart';

Future<UserModel> GetUserData(String doc)async{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  UserModel userModel=UserModel(doc: doc, email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  await firestore.collection('user').doc(doc).get().then((value){
    userModel=UserModel(
        doc: doc, email: value.get('email'),
        phone: value.get('phone'), name: value.get('name'),
        pic: value.get('pic'), type: value.get('type'));
        return userModel;
  });
  return userModel;
}