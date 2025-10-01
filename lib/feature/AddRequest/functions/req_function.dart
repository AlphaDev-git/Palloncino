import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/item_model.dart';
import 'package:pallon_app/models/req_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';
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


void Submit(UserModel user,bool des,ReqModel req,List<CatalogItemModel> items,String notes,double deposit,double fees,double total,String branch,String bank)async{
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
      'notes':notes,
      'banktype':bank,
      'branch':branch
    }).whenComplete(()async{
      for(int i=0;i<items.length;i++){
        await _firestore.collection('req').doc(doc).collection('item').doc().set({
          'name':items[i].name,
          'price':items[i].price.toString(),
          'des':items[i].des.toString(),
          'path':items[i].path
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
    List<File>_images,List<CatalogItemModel> items,String notes,double deposit,double fees,double total,String branch,String bank)async{
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
      'notes':notes,
      'banktype':bank,
      'branch':branch
    }).whenComplete(()async{
      for(int i=0;i<items.length;i++){
        await _firestore.collection('req').doc(doc).collection('item').doc().set({
          'name':items[i].name,
          'price':items[i].price.toString(),
          'notes':items[i].des,
          'path':items[i].path
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

Future<List<Catalog>> GetAllCatalogData()async{
  List<Catalog> cat=[];
  try{
    await _firestore.collection('Catalog').get().then((value){
      for(int i=0;i<value.size;i++){
        cat.add(
            Catalog(doc: value.docs[i].id, cat: value.docs[i].get('cat'), pic: value.docs[i].get('pic'))
        );
      }
    }).whenComplete(()async{
      for(int i=0;i<cat.length;i++){
        await _firestore.collection('Catalog').doc(cat[i].doc).collection('sub').get().then((value){
          List<SubCatModel> sub=[];
          for(int j=0;j<value.size;j++){
            sub.add(
                SubCatModel(doc: value.docs[j].id,
                    sub: value.docs[j].get('sub'), pic: value.docs[j].get('pic'))
            );
          }
          cat[i].sub=sub;
        }).whenComplete(()async{
          for(int j=0;j<cat[i].sub.length;j++){
            await _firestore.collection('Catalog').doc(cat[i].doc).collection('sub').doc(cat[i].sub[j].doc).collection('subsub').get().then((value){
              List<SubSubCatModel> subsub=[];
              for(int k=0;k<value.size;k++){
                subsub.add(
                  SubSubCatModel(
                      doc: value.docs[k].id,
                      subsub: value.docs[k].get('subsub'),
                      pic: value.docs[k].get('pic'))
                );
              }
              cat[i].sub[j].subsub=subsub;
            }).whenComplete(()async{
              for(int k=0;k<cat[i].sub[j].subsub.length;k++){
                await _firestore.collection('Catalog').doc(cat[i].doc).collection('sub')
                    .doc(cat[i].sub[j].doc).collection('subsub').doc(cat[i].sub[j].subsub[k].doc).collection('item').get().then((value){
                      List<CatalogItemModel> items=[];
                      for(int m=0;m<value.size;m++){
                     items.add(
                       CatalogItemModel(
                           doc: value.docs[m].id,
                           name: value.docs[m].get('name'),
                           path: value.docs[m].get('path'),
                           des: value.docs[m].get('des'),
                           price: value.docs[m].get('price')
                       )
                     );
                   }
                      cat[i].sub[j].subsub[k].items=items;
                });
              }
            });
          }
        });
      }
    });
  }
  catch(e){
    print(e);
    return [];
  }
  return cat;
}