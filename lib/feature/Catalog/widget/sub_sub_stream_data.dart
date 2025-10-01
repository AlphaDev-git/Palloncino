import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/Funcation/catalog_function.dart';
import 'package:pallon_app/feature/Catalog/widget/catalog_item_widget.dart';
import 'package:pallon_app/feature/Catalog/widget/edit_subsub_widget.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';
import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';


Widget SubSubStreamData(BuildContext context,SubCatModel sub,Catalog catalog){
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection("Catalog").doc(catalog.doc).collection('sub').doc(sub.doc).collection('subsub').snapshots(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF07933E),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items found.'),
          );
        }
        List<SubSubCatModel> subsub=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          subsub.add(
              SubSubCatModel(doc: message.id, subsub: message.get('subsub'), pic: message.get('pic'))
          );
        }
        return ListView.builder(
          itemCount: subsub.length,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 2,
                child: ListTile(
                  onTap: (){
                    Get.to(CatalogItemWidget(catalog,sub,subsub[index]),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                  },
                  enableFeedback: true,
                  title: Text(subsub[index].subsub),
                  trailing:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: (){
                            Get.bottomSheet(
                               EditSubSubWidget(cat: catalog, sub: sub, subsub: subsub[index]),
                                clipBehavior: Clip.hardEdge,
                                enableDrag: true,
                                persistent: true,
                                ignoreSafeArea: true
                            );
                          }, icon: Icon(Icons.edit_outlined,color: Colors.green,)),
                      IconButton(onPressed: ()async{
                        DeleteSubSub(context, catalog, sub, subsub[index]);
                      }, icon: Icon(Icons.delete_sweep_outlined,color: Colors.red,))
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(subsub[index].pic),
                  ),
                ),
              ),
            );
          },
        );
      }
  );
}