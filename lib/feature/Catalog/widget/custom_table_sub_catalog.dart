import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/Funcation/catalog_function.dart';
import 'package:pallon_app/feature/Catalog/view/subsub_view.dart';
import 'package:pallon_app/feature/Catalog/widget/edit_sub_category_catalog_widget.dart';
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
            itemCount: subcatalogs.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                    onTap: (){
                      Get.to(
                          SubSubView(widget.catalog, subcatalogs[index]),
                         // CatalogItemWidget(widget.catalog,subcatalogs[index]),
                          transition: Transition.fadeIn,duration: Duration(seconds: 1));
                    },
                    enableFeedback: true,
                    title: Text(subcatalogs[index].sub),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (){
                              Get.bottomSheet(
                                  EditSubCategoryCatalog(widget.catalog,subcatalogs[index]),
                                  clipBehavior: Clip.hardEdge,
                              );
                            }, icon: Icon(Icons.edit_outlined,color: Colors.green,)),
                        IconButton(onPressed: ()async{
                          DeleteSubCategory(context, widget.catalog, subcatalogs[index]);
                        }, icon: Icon(Icons.delete_sweep_outlined,color: Colors.red,))
                      ],
                    ),
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