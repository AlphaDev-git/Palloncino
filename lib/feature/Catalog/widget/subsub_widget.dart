import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Catalog/view/create_sub_sub_view.dart';
import 'package:pallon_app/feature/Catalog/widget/sub_sub_stream_data.dart';
import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';


class SubSubWidget extends StatefulWidget{
  SubCatModel sub;
  Catalog catalog;
  SubSubWidget(this.catalog,this.sub);
  @override
  State<StatefulWidget> createState() {
    return _SubSubWidget();
  }
}


class _SubSubWidget extends State<SubSubWidget>{
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
              child: SubSubStreamData(context,widget.sub, widget.catalog),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.bottomSheet(CreateSubSubView(widget.catalog,widget.sub));
      },child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.grey[100],),
    );
  }
}