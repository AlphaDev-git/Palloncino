import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Client/widget/stream_banners.dart';

import '../../../Core/Widgets/common_widgets.dart';
import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';

class ClientHomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClientHomeWidget();
  }

}


class _ClientHomeWidget extends State<ClientHomeWidget>{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserType();
  }
  void GetUserType()async{
    userModel =await GetUserData(_auth.currentUser!.uid);
    setState(() {
      userModel;
    });
  }
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
                            'Good Morning',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.019),
                          Text(
                            userModel!.name == "name" || userModel!.name == ""
                                ? userModel!.email
                                : userModel!.name,
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
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
            SizedBox(height: screenHeight*0.002,),
            SizedBox(
              height: screenHeight*0.13,
              child: StreamBanner(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02),
              child: Text(
                'All Request',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.015,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xFF07933E),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Candidate Management',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          'For - Zoho Project',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teammates',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Row(
                                  children: [
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(isMore: true, count: 3),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due date',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  'June 6, 2022',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        child: CircularProgressIndicator(
                          value: 0.88,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFCE232B)),
                        ),
                      ),
                      Text(
                        '88%',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFCE232B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight*0.04,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.015,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xFF07933E),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Candidate Management',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          'For - Zoho Project',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teammates',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Row(
                                  children: [
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(isMore: true, count: 3),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due date',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  'June 6, 2022',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        child: CircularProgressIndicator(
                          value: 0.88,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFCE232B)),
                        ),
                      ),
                      Text(
                        '88%',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFCE232B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight*0.04,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.015,
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xFF07933E),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Candidate Management',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          'For - Zoho Project',
                          style: TextStyle(
                            fontSize: screenWidth * 0.035,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Teammates',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Row(
                                  children: [
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(),
                                    buildAvatar(isMore: true, count: 3),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Due date',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  'June 6, 2022',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        child: CircularProgressIndicator(
                          value: 0.88,
                          strokeWidth: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFFCE232B)),
                        ),
                      ),
                      Text(
                        '88%',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFCE232B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}