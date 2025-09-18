import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import 'catalog_item_widget.dart';


class SubCatalogStreamWidget extends StatefulWidget{
  Catalog catalog;
  SubCatalogStreamWidget(this.catalog);
  @override
  State<StatefulWidget> createState() {
    return _SubCatalogStreamWidget();
  }
}


class _SubCatalogStreamWidget extends State<SubCatalogStreamWidget>{
  FirebaseFirestore _firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Catalog').doc(widget.catalog.doc).collection('sub').snapshots(),
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
        List<SubCatModel> subcatalogs=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          subcatalogs.add(
              SubCatModel(doc: message.id, sub: message.get('sub'),pic: message.get('pic'))
          );
        }
        widget.catalog.sub=subcatalogs;
        return ListView.builder(
            itemCount: widget.catalog.sub.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    onTap: (){
                      Get.to(CatalogItemWidget(widget.catalog,widget.catalog.sub[index]),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                    },
                    enableFeedback: true,
                    title: Text(widget.catalog.sub[index].sub),
                    trailing:Icon(Icons.arrow_forward_outlined),
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(widget.catalog.sub[index].pic),
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