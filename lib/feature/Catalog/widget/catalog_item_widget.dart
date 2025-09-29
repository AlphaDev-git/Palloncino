import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/view/create_catalog_item_view.dart';
import 'package:pallon_app/feature/Catalog/widget/gradview_item_catalog.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';

import '../Funcation/catalog_function.dart';



class CatalogItemWidget extends StatefulWidget{
  Catalog cat;
  SubCatModel sub;
  CatalogItemWidget(this.cat,this.sub);
  @override
  State<StatefulWidget> createState() {
    return _CatalogItemWidget();
  }
}



class _CatalogItemWidget extends State<CatalogItemWidget>{


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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.25,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF07933E),
                    Color(0xFF007530),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sub.sub,
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
                height: screenHeight*0.7,
                child: GradviewItemCatalog(widget.cat, widget.sub),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Get.bottomSheet(CreateCatalogItemView(widget.cat,widget.sub));
        },
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.white,
      ),
    );
  }

}