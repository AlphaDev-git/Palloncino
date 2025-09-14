import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/MainScreen/view/main_screen_view.dart';
import 'package:restart_app/restart_app.dart';

void SignInMethod(String email , String password,BuildContext context)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  try{
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      Get.back();
      Get.back();
      Get.to(MainScreenView(),transition:Transition.downToUp,duration: Duration(seconds: 1));
    });
  }
  catch(e){
    print(e);
  }
}

void SignUpMethod(String name,File img,String email,String password, String phone,BuildContext context)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  try{
    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value)async{
      await firestore.collection('user').doc(auth.currentUser!.uid).set({
        'doc':auth.currentUser!.uid,
        'phone':phone,
        'email':email,
        'name':name,
        'pic':"",
        'type':'client'
      }).then((value){
        Get.back();
        Get.back();
        Get.back();
        Get.to(MainScreenView(),transition:Transition.downToUp,duration: Duration(seconds: 1));
      });
    });
  }
  catch(e){
    print(e);
  }
}