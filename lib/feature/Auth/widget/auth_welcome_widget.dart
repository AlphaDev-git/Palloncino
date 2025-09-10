import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Auth/view/auth_signin_view.dart';

import 'PinkWaveClipper.dart';


class AuthWelcomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AuthWelcomeWidget();
  }
  
}


class _AuthWelcomeWidget extends State<AuthWelcomeWidget>{
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Green Wavy Background
          ClipPath(
            clipper: PinkWaveClipper(),
            child: Container(
              height: screenHeight * 0.6,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF07933E),
                    Color(0xFF007530),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // White Wavy Foreground
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: WhiteWaveClipper(),
              child: Container(
                height: screenHeight * 0.6,
                color: Colors.white,
              ),
            ),
          ),
          // Content (Text and Button)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.35),
                // Welcome Text
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF000000),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Sub-text
                Text(
                  'Your journey to a better life starts here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: screenWidth * 0.045,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.08),
                // Continue Button
                GestureDetector(
                  onTap: () {
                    Get.to(AuthSignInView(),transition: Transition.cupertino,duration: Duration(seconds: 1));
                  },
                  child: Container(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCE232B),
                      borderRadius: BorderRadius.circular(screenWidth * 0.05),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCE232B).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Container(
                          width: screenWidth * 0.08,
                          height: screenWidth * 0.08,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: screenWidth * 0.04,
                            color: const Color(0xFFCE232B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}