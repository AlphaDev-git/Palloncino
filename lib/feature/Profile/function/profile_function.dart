import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/splash/views/splash_view.dart';

import '../../../Core/Widgets/common_widgets.dart';
FirebaseAuth auth=FirebaseAuth.instance;
FirebaseFirestore firestore=FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
void updateProfile(String name,String phone,File image,BuildContext context)async{
  final path = "agent/photos/${auth.currentUser!.uid}-${DateTime.now().toString()}.jpg";
  final ref = FirebaseStorage.instance.ref().child(path);
  final uploadTask = ref.putFile(image);
  final snapshot = await uploadTask.whenComplete(() {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  await firestore.collection('user').doc(auth.currentUser!.uid).update({
    'pic':urlDownload,
    'name':name,
    'phone':phone
  }).whenComplete((){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile Updated Successfully!'),
        backgroundColor: Color(0xFF07933E),
      ),
    );
  });

}

void logout(BuildContext context)async{
  try{
    await auth.signOut().whenComplete((){
      Get.offAll(SplashView());
    });
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Can't Logout"),
        backgroundColor: Color(0xFF07933E),
      ),
    );
  }
}

void RemoveAccount(BuildContext context)async{
  try{
    await firestore.collection('user').doc(auth.currentUser!.uid).delete().whenComplete(()async{
      await auth.currentUser!.delete().whenComplete((){
        Get.offAll(SplashView());
      });
    });
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Can't Remove Account"),
        backgroundColor: Color(0xFF07933E),
      ),
    );
  }
}

void UpdatePasswordProfile(TextEditingController pass,BuildContext context)async{
  try{
    await auth.currentUser!.updatePassword(pass.text).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}