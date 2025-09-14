import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/models/user_model.dart';



final FirebaseAuth _auth=FirebaseAuth.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<List<UserModel>> GetAllStaff()async{
  List<UserModel> users=[];
  try{
    await _firestore.collection('user').where('type',isNotEqualTo: 'client').get().then((value){
     for(int i=0;i<value.size;i++){
       if(value.docs[i].id==_auth.currentUser!.uid){

       }
       else{
         users.add(
             UserModel(
                 doc: value.docs[i].id, email: value.docs[i].get('email'),
                 phone: value.docs[i].get('phone'), name: value.docs[i].get('name'),
                 pic: value.docs[i].get('pic'), type: value.docs[i].get('type'))
         );
       }
     }
    });
    return users;
  }
  catch(e){
    print(e);
    return users;
  }
}


Future<List<UserModel>> GetAllClients()async{
  List<UserModel> users=[];
  try{
    await _firestore.collection('user').where('type',isEqualTo: 'client').get().then((value){
      for(int i=0;i<value.size;i++){
        users.add(
            UserModel(
                doc: value.docs[i].id, email: value.docs[i].get('email'),
                phone: value.docs[i].get('phone'), name: value.docs[i].get('name'),
                pic: value.docs[i].get('pic'), type: value.docs[i].get('type'))
        );
      }
    });
    return users;
  }
  catch(e){
    print(e);
    return users;
  }
}