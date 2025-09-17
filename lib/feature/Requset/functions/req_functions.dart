import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pallon_app/models/item_model.dart';
import 'package:pallon_app/models/req_data_model.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Future<ReqDataModel> GetReqDesign(ReqDataModel req)async{
  ReqDataModel data=req;
  try{
    List<String> photos=[];
    await _firestore.collection('req').doc(req.doc).collection('des').get().then((value){
      for(int i=0;i<value.size;i++){
        photos.add(value.docs[i].get('path'));
      }
    }).whenComplete((){
      data.des=photos;
      return data;
    });
    return data;
  }
  catch(e){
    print(e);
    return data;
  }
}


Future<ReqDataModel>GetReqItem(ReqDataModel req)async{
  ReqDataModel data=req;
  List<ItemModel> items=[];
  try{
    await _firestore.collection('req').doc(req.doc).collection('item').get().then((value){
      for(int i=0;i<value.size;i++){
        items.add(
          ItemModel(doc: "doc", id: "id",
              name: value.docs[i].get('name'), count: int.parse(value.docs[i].get('count')),
              price: double.parse(value.docs[i].get('price')), pic: "pic", show: true)
        );
      }
    }).whenComplete((){
      data.item=items;
    });
    return data;
  }
  catch(e){
    print(e);
    return data;
  }
}