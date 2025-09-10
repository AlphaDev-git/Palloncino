import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
void updateProfile(String name,String phone,File image,BuildContext context)async{
  FirebaseAuth auth=FirebaseAuth.instance;
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
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