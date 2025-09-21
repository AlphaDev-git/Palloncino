import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/widget/edit_cateory_widget.dart';
import 'package:pallon_app/feature/Catalog/widget/sub_catalog_widget.dart';
import 'package:pallon_app/models/catalog_model.dart';


class CatalogStreamWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClassStreamWidget();
  }
}


class _ClassStreamWidget extends State<CatalogStreamWidget>{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Catalog').snapshots(),
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
        List<Catalog> catalogs=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          catalogs.add(
            Catalog(doc: message.id, cat: message.get('cat'),pic: message.get('pic'))
          );
        }
        return ListView.builder(
            itemCount: catalogs.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    onTap: (){
                      Get.to(SubCatalogWidgte(catalogs[index]),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                    },
                    enableFeedback: true,
                    title: Text(catalogs[index].cat),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (){
                              Get.bottomSheet(
                                EditCategoryWidget(catalogs[index]),
                                clipBehavior: Clip.hardEdge,
                                enableDrag: true,
                                persistent: true,
                                ignoreSafeArea: true
                              );
                            }, icon: Icon(Icons.edit_outlined,color: Colors.green,)),
                        IconButton(onPressed: ()async{
                          await _firestore.collection('Catalog').doc(catalogs[index].doc).delete();
                        }, icon: Icon(Icons.delete_sweep_outlined,color: Colors.red,))
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(catalogs[index].pic),
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
}