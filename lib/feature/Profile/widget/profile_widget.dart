import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Profile/widget/profile_list_option_widget.dart';
import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';


class ProfileWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileWidget();
  }
}

class _ProfileWidget extends State<ProfileWidget>{
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.35,
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
                      'Profile',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundColor: Colors.white,
                              child: userModel.pic == "" || userModel.pic =="pic"
                                  ?
                              Icon(
                                Icons.person,
                                size: screenWidth * 0.15,
                                color: Colors.grey[300],
                              ):ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: userModel.pic,
                                  width: screenWidth * 0.3,
                                  height: screenWidth * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Welcome ${userModel.name}", // Placeholder for user's job title
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: CustomListOptions(context, userModel),
            )
          ],
        ),
      ),
    );
  }

}