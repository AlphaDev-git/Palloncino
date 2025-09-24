import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/Core/Widgets/common_widgets.dart';
import 'package:pallon_app/Core/Widgets/image_view.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/banner_model.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;


Widget StreamBanner(BuildContext context){
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
      return CarouselSlider(
        options: CarouselOptions(
          height: 94,
          autoPlay: banners.length > 1,
          enableInfiniteScroll: true,
        ),
        items: banners.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                margin:
                const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: InkWell(
                    onTap: (){
                      if(imageUrl.typeaction=="same"){
                        Get.to(ViewImage(imageUrl.path),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                      }
                      else if(imageUrl.typeaction=="image"){
                        Get.to(ViewImage(imageUrl.action),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                      }
                      else{
                        try{
                          final Uri url = Uri.parse(
                            imageUrl.action,
                          );
                          _launchInBrowser(url);
                        }
                        catch(e){
                          showErrorDialog(context, e.toString());
                        }
                      }
                    },
                    child: Image.network(
                      imageUrl.path,
                      fit: BoxFit.fill,
                      errorBuilder:
                          (context, error, stackTrace) {
                        return  Center(
                            child: Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.black45),
                            ));
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    },
  );
}
Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url, mode: LaunchMode.externalApplication,)) {
    throw Exception('Could not launch $url');
  }
}
