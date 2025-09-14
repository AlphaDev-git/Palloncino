import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/item_model.dart';
import 'package:pallon_app/models/req_model.dart';
import 'package:pallon_app/models/user_model.dart';


FirebaseFirestore _firestore=FirebaseFirestore.instance;
FirebaseAuth _auth=FirebaseAuth.instance;


Future<List<ItemModel>> GetItemsList()async{
  List<ItemModel> items=[];
  try{
    await _firestore.collection('item').get().then((value){
      for(int i=0;i<value.size;i++){
        items.add(
            ItemModel(doc: value.docs[i].id,
                id: value.docs[i].get('id'), name: value.docs[i].get('Item'),
                count: int.parse(value.docs[i].get('count')), price: double.parse(value.docs[i].get('price')),
                pic: value.docs[i].get('pic'), show: bool.parse(value.docs[i].get('show')))
        );
      }
    });
    return items;
  }
  catch(e){
    print(e);
    return [];
  }
}


void Submit(UserModel user,bool des,ReqModel req,List<ItemModel> items,String notes,double deposit,double fees,double total)async{
  try{
    String doc="Doc${DateTime.now().toString()}";
    await _firestore.collection('req').doc(doc).set({
      'createby':user.name,
      'typeCreate':user.type,
      'status':"inreview",
      'name':req.Name,
      'phone':req.Phone,
      'typeofevent':req.TypeOfEvent,
      'ownerofevent':req.OwnerOfEvent,
      'hour':req.Hour,
      'date':req.Date,
      'address':req.Address,
      'typeofbuilding':req.TypeOfBuilding,
      'float':req.Float,
      'desgin':des.toString(),
      'deposit':deposit.toString(),
      'total':total.toString(),
      'fees':fees.toString(),
      'notes':notes
    }).whenComplete(()async{
      for(int i=0;i<items.length;i++){
        await _firestore.collection('req').doc(doc).collection('item').doc().set({
          'name':items[i].name,
          'price':items[i].price.toString(),
          'count':items[i].count.toString()
        });
      }
    }).then((value){
      Get.back();
    });
  }
  catch(e){
    print(e);
  }
}
void Submit2(UserModel user,bool des,ReqModel req,
    List<File>_images,List<ItemModel> items,String notes,double deposit,double fees,double total)async{
  try{
    List<String> urlImages=[];
    for(int i=0;i<_images.length;i++){
      final path = "user/photos/${_auth.currentUser!.uid}-${DateTime.now().toString()}.jpg";
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(_images[i]);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      urlImages.add(urlDownload);
    }
    String doc="Doc${DateTime.now().toString()}";
    await _firestore.collection('req').doc(doc).set({
      'status':"inreview",
      'createby':user.name,
      'typeCreate':user.type,
      'name':req.Name,
      'phone':req.Phone,
      'typeofevent':req.TypeOfEvent,
      'ownerofevent':req.OwnerOfEvent,
      'hour':req.Hour,
      'date':req.Date,
      'address':req.Address,
      'typeofbuilding':req.TypeOfBuilding,
      'float':req.Float,
      'desgin':des.toString(),
      'deposit':deposit.toString(),
      'total':total.toString(),
      'fees':fees.toString(),
      'notes':notes
    }).whenComplete(()async{
      for(int i=0;i<items.length;i++){
        await _firestore.collection('req').doc(doc).collection('item').doc().set({
          'name':items[i].name,
          'price':items[i].price.toString(),
          'count':items[i].count.toString()
        });
      }
    }).whenComplete(()async{
      for(int i=0;i<urlImages.length;i++){
        await _firestore.collection('req').doc(doc).collection('des').doc().set({
          'path':urlImages[i],
        });
      }
    }).then((value){
      Get.back();
    });
  }
  catch(e){
    print(e);
  }

}