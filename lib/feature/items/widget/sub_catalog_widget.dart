import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/items/widget/custom_table_sub_catalog.dart';
import 'package:pallon_app/models/catalog_model.dart';



class SubCatalogWidgte extends StatefulWidget{
  Catalog cat;
  SubCatalogWidgte(this.cat);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SubCatalogWidget();
  }
}



class _SubCatalogWidget extends State<SubCatalogWidgte>{
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
                            "${widget.cat.cat}",
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(onPressed: (){
                       // Get.to(AddItemView(),duration: Duration(seconds: 1),transition: Transition.zoom);
                      }, icon: Icon(Icons.add,color: Colors.black,))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
                height: screenHeight*0.6,
                child: SubCatalogStreamWidget(widget.cat)
            )
          ],
        ),
      ),
    );
  }

}