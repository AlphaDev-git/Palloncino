import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pallon_app/Core/Widgets/common_widgets.dart';
import 'package:pallon_app/feature/Profile/function/profile_function.dart';
import '../../splash/views/splash_view.dart';

void SignInMethod(String email , String password,BuildContext context)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  try{
    await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
      Get.offAll(SplashView());
    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
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
        Get.offAll(SplashView());
      });
    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}

void SignInWithGoogle(BuildContext context)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  try{
    GoogleSignIn sign=GoogleSignIn.instance;
    sign.initialize(serverClientId: "444759864301-kcmhlopmi32t4l1mps1j2d3tvctn22o1.apps.googleusercontent.com");
    final googleuser=await sign.authenticate();
    final GoogleSignInAuthentication googleAuth=googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    auth.signInWithCredential(credential).then((value)async{
      await firestore.collection('user').doc(auth.currentUser!.uid).get().then((value)async{
        if(value.exists){
          Get.offAll(SplashView());
        }
        else{
          await firestore.collection('user').doc(auth.currentUser!.uid).set({
            'doc':auth.currentUser!.uid,
            'phone':auth.currentUser!.phoneNumber,
            'email':auth.currentUser!.email,
            'name':auth.currentUser!.displayName,
            'pic':auth.currentUser!.photoURL,
            'type':'client'
          }).then((value){
            Get.offAll(SplashView());
          });
        }
      });
    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}