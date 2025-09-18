import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/Core/Widgets/common_widgets.dart';
import 'package:pallon_app/models/item_model.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;

void SaveNewItem(ItemModel item,File image,BuildContext context)async{
  try{
    final path = "item/photos/item-${DateTime.now().toString()}.jpg";
    final ref = FirebaseStorage.instance.ref().child(path);
    final uploadTask = ref.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    await _firestore.collection('item').doc().set({
      'count':item.count.toString(),
      'Item':item.name,
      'id':item.id,
      'price':item.price.toString(),
      'pic':urlDownload,
      'show':item.show.toString()
    }).whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item Save Successfully!'),
          backgroundColor: Color(0xFF07933E),
        ),
      );
      Get.back();
    });
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item Save Field!"),
        backgroundColor: Color(0xFF07933E),
      ),
    );
    Get.back();
  }
}
void EditItemAction(ItemModel item,File image,BuildContext context)async{
  try{
    if(image!=null){
      final path = "item/photos/item-${DateTime.now().toString()}.jpg";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(image);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      await _firestore.collection('item').doc(item.doc).update({
        'count':item.count.toString(),
        'Item':item.name,
        'id':item.id,
        'price':item.price.toString(),
        'pic':urlDownload,
        'show':item.show.toString()
      }).whenComplete((){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item Updated Successfully!'),
            backgroundColor: Color(0xFF07933E),
          ),
        );
        Get.back();
      });
    }
    else{
      await _firestore.collection('item').doc(item.doc).update({
        'count':item.count.toString(),
        'Item':item.name,
        'id':item.id,
        'price':item.price.toString(),
        'pic':item.pic,
        'show':item.show.toString()
      }).whenComplete((){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item Updated Successfully!'),
            backgroundColor: Color(0xFF07933E),
          ),
        );
        Get.back();
      });
    }

  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item Updated Field!"),
        backgroundColor: Color(0xFF07933E),
      ),
    );
    Get.back();
  }
}


void EditItemAction2(ItemModel item,BuildContext context)async{
  try{
    await _firestore.collection('item').doc(item.doc).update({
      'count':item.count.toString(),
      'Item':item.name,
      'id':item.id,
      'price':item.price.toString(),
      'pic':item.pic,
      'show':item.show.toString()
    }).whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item Updated Successfully!'),
          backgroundColor: Color(0xFF07933E),
        ),
      );
      Get.back();
    });

  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Item Updated Field!"),
        backgroundColor: Color(0xFF07933E),
      ),
    );
    Get.back();
  }
}


void RemoveItem(ItemModel item,BuildContext context)async{
  try{
    await _firestore.collection('item').doc(item.doc).delete().whenComplete((){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item Remove Successfully!'),
          backgroundColor: Color(0xFF07933E),
        ),
      );
      Get.back();
    });
  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item Remove Field!'),
        backgroundColor: Color(0xFF07933E),
      ),
    );
    Get.back();
  }
}



