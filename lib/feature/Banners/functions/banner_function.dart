import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/banner_model.dart';
import '../../../Core/Widgets/common_widgets.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;

void AddBannerSame(BuildContext context,File image)async{
  try{
    String doc=DateTime.now().toString();
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).set({
      'doc':doc,
      "action":urlDownload,
      'typeaction':'same',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void AddBannerLink(BuildContext context,File image,TextEditingController link)async{
  try{
    String doc=DateTime.now().toString();
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).set({
      'doc':doc,
      "action":link.text,
      'typeaction':'link',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void AddBannerImage(BuildContext context,File image,File image2)async{
  try{
    String doc=DateTime.now().toString();
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    final path2 = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref2 = FirebaseStorage.instance.ref().child(path2);
    final uploadTask2 = ref2.putFile(image2!);
    final snapshot2 = await uploadTask2.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).set({
      'doc':doc,
      "action":urlDownload2,
      'typeaction':'link',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void DeleteBanner(BuildContext context,BannerModel banner)async{
  try{
    await _firestore.collection('banner').doc(banner.doc).delete().whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void UpdateSame(BuildContext context ,File image,String doc)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      "action":urlDownload,
      'typeaction':'same',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void UpdateImage(BuildContext context,File image,String doc)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      "action":urlDownload,
      'typeaction':'image',
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void UpdateImage2(BuildContext context,File image,String doc)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      'typeaction':'image',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void UpdateImage3(BuildContext context,File image,File image2,String doc)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    final path2 = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref2 = FirebaseStorage.instance.ref().child(path2);
    final uploadTask2 = ref2.putFile(image2!);
    final snapshot2 = await uploadTask2.whenComplete(() {});
    final urlDownload2 = await snapshot2.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      'action':urlDownload2,
      'typeaction':'image',
      'path':urlDownload
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void UpdateLink(BuildContext context,String doc,TextEditingController link)async{
  try{
    await _firestore.collection('banner').doc(doc).update({
      'action':link.text.toString(),
      'typeaction':'link',
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void UpdateLink2(BuildContext context,String doc,File image)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      'path':urlDownload,
      'typeaction':'link',
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void UpdateLink3(BuildContext context,String doc,File image,TextEditingController link)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('banner').doc(doc).update({
      'path':urlDownload,
      'typeaction':'link',
      'action':link.text.toString()
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


