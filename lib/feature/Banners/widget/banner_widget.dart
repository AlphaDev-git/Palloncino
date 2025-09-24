import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Banners/widget/graidview_banners.dart';

class BannerWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BannerWidget();
  }
}


class _BannerWidget extends State<BannerWidget>{
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
                height: screenHeight * 0.19,
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
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.08,
                      left: screenWidth * 0.08,
                      child: Text(
                        'Banners',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight*0.20,
                child: GradViewBanners(context),
              ),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add,color: Colors.black,),
        backgroundColor: Colors.white,
      ),
    );
  }
}