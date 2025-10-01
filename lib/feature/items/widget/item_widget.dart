import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/items/view/add_item_view.dart';
import 'package:pallon_app/feature/items/widget/custom_item_table.dart';

class ItemWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ItemWidget();
  }

}


class _ItemWidget extends State<ItemWidget>{
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
                            'Items',
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
            SizedBox(height: screenHeight * 0.045),
            CustomeItemTable(context)
          ],
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          Get.to(AddItemView(),duration: Duration(seconds: 1),transition: Transition.zoom);
        },
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.white,
      ),
    );
  }

}