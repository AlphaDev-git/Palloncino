import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/item_model.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;


void AddItem(BuildContext context){
  TextEditingController id=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery
            .of(context)
            .size
            .height;
        final screenWidth = MediaQuery
            .of(context)
            .size
            .width;
        return AlertDialog(
            title: Text("Add New Item"),
            content: Container(
                height: screenHeight*0.4,
                width: screenWidth*0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Id"),
                    TextField(
                      controller: id,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Text("Name"),
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Text("Count"),
                    TextField(
                      controller: number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){
                          ItemModel item=ItemModel(
                              doc: "",
                              id: id.text, name: name.text, count: int.parse(number.text));
                          _SaveNewItem(item, context);
                        }, child: Text("Add New Item")),
                      ],
                    )
                  ],
                )
            )
        );
      });
}

void EditItem(ItemModel item,BuildContext context){
  TextEditingController number=TextEditingController(
    text: item.count.toString()
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final screenHeight = MediaQuery
            .of(context)
            .size
            .height;
        final screenWidth = MediaQuery
            .of(context)
            .size
            .width;
        return AlertDialog(
            title: Text("Action"),
            content: Container(
                height: screenHeight*0.2,
                width: screenWidth*0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Edit Count"),
                    TextField(
                      controller: number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: screenHeight*0.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: (){
                          _SaveNewCount(item, int.parse(number.text), context);
                        }, child: Text("Save")),
                        ElevatedButton(onPressed: (){
                          _RemoveItem(item, context);
                        }, child: Text("Delete")),
                      ],
                    )
                  ],
                )
            )
        );
      });
}
void _SaveNewItem(ItemModel item,BuildContext context)async{
  try{
    await _firestore.collection('item').doc().set({
      'count':item.count.toString(),
      'Item':item.name,
      'id':item.id
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
void _SaveNewCount(ItemModel item,int count,BuildContext context)async{
  try{
    await _firestore.collection('item').doc(item.doc).update({
      'count':count.toString()
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

void _RemoveItem(ItemModel item,BuildContext context)async{
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