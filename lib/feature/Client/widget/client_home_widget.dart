import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }

}