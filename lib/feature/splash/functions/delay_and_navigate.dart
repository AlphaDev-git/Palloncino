import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Auth/view/auth_welcome_view.dart';
import 'package:pallon_app/feature/MainScreen/view/main_screen_view.dart';


void delayAndNavigate(BuildContext context) {
  FirebaseAuth auth=FirebaseAuth.instance;
  Future.delayed(const Duration(seconds: 4)).then((value) {
    if(auth.currentUser !=null){
      Get.to(MainScreenView(),duration: Duration(seconds: 1),transition: Transition.zoom);
    }
    else{
      Navigator.popAndPushNamed(context, AuthLoginView.id);
    }
  });
}
