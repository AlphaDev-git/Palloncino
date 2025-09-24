import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Banners/view/edit_banner_view.dart';
import 'package:pallon_app/models/banner_model.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;


Widget GradViewBanners(BuildContext context){
  final screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  double imagePreviewWidth = screenWidth * 0.4;
  double imagePreviewMargin = screenWidth * 0.02;
  double imagePreviewBorderRadius = screenWidth * 0.02;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('banner').snapshots(),
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
      List<BannerModel> banners=[];
      final messages = snapshot.data!.docs;
      for (var message in messages.reversed){
        banners.add(
          BannerModel(doc: message.id,
              path: message.get('path'),
              action: message.get('action'), typeaction: message.get('typeaction'))
        );
      }
      return GridView.builder(
          itemCount: banners.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: screenWidth * 0.05,
            crossAxisSpacing: screenWidth * 0.05,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Get.to(EditBannerView(banners[index]),transition: Transition.fadeIn,duration: Duration(seconds: 1));
              },
              child: Container(
                width: imagePreviewWidth,
                margin: EdgeInsets.all(imagePreviewMargin),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(imagePreviewBorderRadius),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(banners[index].path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
      );
    },
  );
}