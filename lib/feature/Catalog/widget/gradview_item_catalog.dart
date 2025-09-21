import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/Core/Widgets/custom_item_card.dart';
import 'package:pallon_app/feature/Catalog/view/item_details_catalog_view.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';



class GradviewItemCatalog extends StatefulWidget{
  Catalog cat;
  SubCatModel sub;
  GradviewItemCatalog(this.cat,this.sub);
  @override
  State<StatefulWidget> createState() {
    return _GradviewItemCatalog();
  }
}

class _GradviewItemCatalog extends State<GradviewItemCatalog>{
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
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('Catalog').doc(widget.cat.doc).collection('sub').doc(widget.sub.doc).collection('item').snapshots(),
      builder: (context, snapshot) {
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
        List<CatalogItemModel> items=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          items.add(
              CatalogItemModel(doc: message.id,
                  name: message.get('name'), path: message.get('path'),
                  des: message.get('des'), price: message.get('price'))
          );
        }
        widget.sub.items=items;
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: GridView.builder(
            itemCount: widget.sub.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: screenWidth * 0.03,
              mainAxisSpacing: screenHeight * 0.02,
              childAspectRatio: 0.7,
            ),
              itemBuilder: (context, index){
              return InkWell(
                  child: CustomItemCard(widget.sub.items[index]),
                onTap: (){
                    Get.to(ItemDetailsCatalogView(widget.sub.items[index]),duration: Duration(seconds: 1),
                    transition: Transition.fadeIn);
                },
              );
              }
          ),
        );
      },
    );
  }
}