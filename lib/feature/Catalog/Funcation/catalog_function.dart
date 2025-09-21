import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import '../../../Core/Widgets/common_widgets.dart';
import '../../../models/catalog_model.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;

void createCategory(TextEditingController name,File image,BuildContext context)async{
  try{
    if(image!=null){
      if(name.text!=""){
        final path = "item/photos/item-${DateTime.now().toString()}.jpg";
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(image!);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        await _firestore.collection('Catalog').doc().set({
          'cat':name.text.toString(),
          'pic':urlDownload
        }).whenComplete((){
          Get.back();
        });
      }
      else{
        ErrorCustom(context, "Please Add Name");
      }
    }
    else{
      ErrorCustom(context, "Please Select Image");
    }
  }
  catch(e){
    Get.back();
    ErrorCustom(context, e.toString());
  }
}


void EditCategoty(Catalog cat,File image,TextEditingController name,BuildContext context)async{
  try{
    if(image!=null){
      final path = "item/photos/item-${DateTime.now().toString()}.jpg";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(image!);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await _firestore.collection('Catalog').doc(cat.doc).update({
        'cat':name.text.toString(),
        'pic':urlDownload
      }).whenComplete((){
        Get.back();
      });
    }
    else{
      await _firestore.collection('Catalog').doc(cat.doc).update({
        'cat':name.text.toString(),
      }).whenComplete((){
        Get.back();
      });
    }
  }
  catch(e){
    Get.back();
    ErrorCustom(context, e.toString());
  }
}

void EditSubCategoryCatalogWidget(BuildContext context,File image,TextEditingController name,Catalog cat,SubCatModel sub)async{
  try{
    if(image.path!=""){
      final path = "item/photos/item-${DateTime.now().toString()}.jpg";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(image!);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).update({
        'sub':name.text.toString(),
        'pic':urlDownload
      }).whenComplete((){
        Get.back();
      });
    }
    else{
      await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).update({
        'sub':name.text.toString(),
      }).whenComplete((){
        Get.back();
      });
    }
  }
  catch(e){
    Get.back();
    ErrorCustom(context, e.toString());
  }
}


void DeleteSubCategory(BuildContext context,Catalog cat,SubCatModel sub)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).delete();

  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}


void createSubCategory(TextEditingController name,File image,BuildContext context,Catalog cat)async{
  try{
    if(image!=null){
      if(name.text!=""){
        final path = "item/photos/item-${DateTime.now().toString()}.jpg";
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(image!);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc().set({
          'sub':name.text.toString(),
          'pic':urlDownload,
        }).whenComplete((){
          Get.back();
        });
      }
      else{
        ErrorCustom(context, "Please Add Name");
      }
    }
    else{
      ErrorCustom(context, "Please Select Image");
    }
  }
  catch(e){
    Get.back();
    ErrorCustom(context, e.toString());
  }
}


void CreateCatalogItems(BuildContext context,
    Catalog cat,SubCatModel sub,
    TextEditingController name,TextEditingController des,TextEditingController price,File image)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    String doc=DateTime.now().toString();
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub')
        .doc(sub.doc).collection("item").doc(doc).set({
      'doc':doc,
      'path':urlDownload,
      'name':name.text,
      'des':des.text,
      'price':price.text.toString()
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    print(e);
   Get.back();
    ErrorCustom(context, e.toString());
  }
}