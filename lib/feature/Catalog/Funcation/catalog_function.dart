import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';
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
        showErrorDialog(context, "Please Add Name");
      }
    }
    else{
      showErrorDialog(context, "Please Select Image");
    }
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void EditCategoty2(Catalog cat,TextEditingController name,BuildContext context)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).update({
      'cat':name.text.toString(),
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
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
    showErrorDialog(context, e.toString());
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
    showErrorDialog(context, e.toString());
  }
}


void DeleteSubCategory(BuildContext context,Catalog cat,SubCatModel sub)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).delete();

  }
  catch(e){
    showErrorDialog(context, e.toString());
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
        showErrorDialog(context, "Please Add Name");
      }
    }
    else{
      showErrorDialog(context, "Please Select Image");
    }
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void CreateCatalogItems(BuildContext context,
    Catalog cat,SubCatModel sub,SubSubCatModel subsub,
    TextEditingController name,TextEditingController des,TextEditingController price,File image,
    )async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    String doc=DateTime.now().toString();
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub')
        .doc(sub.doc).collection('subsub').doc(subsub.doc).collection("item").doc(doc).set({
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
    showErrorDialog(context, e.toString());
  }
}


void EditItemCataglog(BuildContext context,TextEditingController name,TextEditingController des,
    TextEditingController price,String doc,Catalog cat,SubCatModel sub,SubSubCatModel subsub)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc)
        .collection('subsub').doc(subsub.doc).collection('item').doc(doc).update({
      'name':name.text.toString(),
      'price':price.text.toString(),
      'des':des.text.toString(),
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}
void EditItemCataglog2(BuildContext context,TextEditingController name,TextEditingController des,
    TextEditingController price,String doc,Catalog cat,SubCatModel sub,File image,SubSubCatModel subsub)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).
    collection('subsub').doc(subsub.doc).collection('item').doc(doc).update({
      'name':name.text.toString(),
      'price':price.text.toString(),
      'des':des.text.toString(),
      'path':urlDownload
    }).whenComplete((){
      Get.back();

    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}

void DeleteItemCatalog(BuildContext context,String doc,Catalog cat,SubCatModel sub,SubSubCatModel subsub)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).collection('subsub').doc(subsub.doc)
        .collection('item').doc(doc).delete().whenComplete((){
          Get.back();
    });
  }
  catch(e){
    ErrorCustom(context, e.toString());
  }
}

Future<List<CatalogItemModel>> GetAllItems(BuildContext context)async{
  List<Catalog> cat=[];
  List<SubCatModel> sub=[];
  List<CatalogItemModel> items=[];
  try{
    await _firestore.collection('Catalog').get().then((value)async{
      for(int i=0;i<value.size;i++){
        cat.add(
            Catalog(doc: value.docs[i].id, cat: value.docs[i].get('cat'), pic: value.docs[i].get('pic'))
        );
        sub=[];
        await _firestore.collection('Catalog').doc(cat[i].doc).collection('sub').get().then((value){
          for(int j=0;j<value.size;j++){
            sub.add(
                SubCatModel(doc: value.docs[j].id, sub: value.docs[j].get('sub'), pic: value.docs[j].get('pic'))
            );
          }
        }).whenComplete(()async{
          cat[i].sub=sub;
          for(int k=0;k<cat[i].sub.length;k++){
            await _firestore.collection('Catalog').doc(cat[i].doc).collection('sub').doc(cat[i].sub[k].doc).collection('item').get().then((value){
              for(int m=0;m<value.size;m++){
                cat[i].sub[k].items.add(
                    CatalogItemModel(doc: value.docs[m].id, name: value.docs[m].get('name'),
                        path: value.docs[m].get('path'), des: value.docs[m].get('des'), price: value.docs[m].get('price'))
                );
                items.add(CatalogItemModel(doc: value.docs[m].id, name: value.docs[m].get('name'),
                    path: value.docs[m].get('path'), des: value.docs[m].get('des'), price: value.docs[m].get('price'))
                );
              }
            });
          }
        });
      }
    });
    return items;
  }
  catch(e){
    ErrorCustom(context, e.toString());
    return items;
  }
}


List<CatalogItemModel> SearchItem(List<CatalogItemModel> allitems,String text){
  List<CatalogItemModel> items=[];
  for(int i=0;i<allitems.length;i++){
    print(allitems[i].name);
    if(allitems[i].name.contains(text)){
      items.add(allitems[i]);
    }
  }
  return items;
}

void CreateSubSubCatalog(BuildContext context,SubCatModel sub,Catalog catalog,File image,TextEditingController name)async{
  try{
    final path = "Catalog/sub/subsub-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    String doc=DateTime.now().toString();
    await _firestore.collection('Catalog').doc(catalog.doc).collection('sub').doc(sub.doc).collection('subsub').doc(doc).set({
      'doc':doc,
      'pic':urlDownload,
      'subsub':name.text
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}


void EditSubSubImage(BuildContext context,Catalog cat,SubCatModel sub,SubSubCatModel subsub,TextEditingController name,File image)async{
  try{
    final path = "Catalog/sub/subsub-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image!);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).collection('subsub').doc(subsub.doc).update({
      'pic':urlDownload,
      'subsub':name.text
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}
void EditSubSub(BuildContext context,Catalog cat,SubCatModel sub,SubSubCatModel subsub,TextEditingController name,)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).collection('subsub').doc(subsub.doc).update({
      'subsub':name.text
    }).whenComplete((){
      Get.back();
    });
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}

void DeleteSubSub(BuildContext context,Catalog cat,SubCatModel sub,SubSubCatModel subsub)async{
  try{
    await _firestore.collection('Catalog').doc(cat.doc).collection('sub').doc(sub.doc).collection('subsub').doc(subsub.doc).delete();
  }
  catch(e){
    showErrorDialog(context, e.toString());
  }
}