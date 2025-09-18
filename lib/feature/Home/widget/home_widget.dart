import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/AddStaff/view/add_staff_view.dart';
import 'package:pallon_app/feature/Requset/view/req_list_view.dart';
import 'package:pallon_app/feature/items/view/add_item_view.dart';
import 'package:pallon_app/feature/items/view/item_view.dart';
import 'package:pallon_app/models/user_model.dart';
import '../../../Core/Widgets/common_widgets.dart';
import '../../MainScreen/function/main_function.dart';


class HomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeWidget();
  }
}

class _HomeWidget extends State<HomeWidget>{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserType();
  }
  void GetUserType()async{
    UserModel user =await GetUserData(_auth.currentUser!.uid);
    setState(() {
      userModel=user;
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
            // Top Header with Green Gradient
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
                          SizedBox(height: screenHeight * 0.005),
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
                      Row(
                        children: [
                          Icon(Icons.notifications_outlined,
                              color: Colors.white, size: screenWidth * 0.06),
                          SizedBox(width: screenWidth * 0.04),
                          Icon(Icons.menu,
                              color: Colors.white, size: screenWidth * 0.06),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // "Select date" Section
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02),
              child: Text(
                'Select date',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            // Date Cards
            SizedBox(
              height: screenHeight * 0.12,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                itemCount: 5,
                itemBuilder: (context, index) {
                  final days = ['MON', 'TUE', 'WED', 'THR', 'FRI'];
                  final dates = [4, 5, 6, 7, 8];
                  final isSelected = index == 0;
                  return Container(
                    width: screenWidth * 0.18,
                    margin: EdgeInsets.only(right: screenWidth * 0.03),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF07933E) : Colors
                          .white,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          days[index],
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          '${dates[index]}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // "Projects" Section
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02),
              child: Text(
                'Access',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            // Project Cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: screenWidth * 0.05,
                crossAxisSpacing: screenWidth * 0.05,
                childAspectRatio: 1.2,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(ReqViewList(),transition: Transition.downToUp,duration: Duration(seconds: 1));
                    },
                    child: buildProjectCard(
                      context,
                      title: 'Requset List',
                      status: 'View List',
                      statusColor: const Color(0xFF07933E),
                    ),
                  ),
                  InkWell(
                    child: buildProjectCard(
                      context,
                      title: 'Staff',
                      status: 'View Staff',
                      statusColor: const Color(0xFF07933E),
                    ),
                    onTap: (){
                      Get.to(AddStaffView(),transition: Transition.topLevel,duration: Duration(seconds: 1));
                    },
                  ),
                  InkWell(
                    child: buildProjectCard(
                      context,
                      title: 'Catalog',
                      status: 'Show Catalog',
                      statusColor: const Color(0xFFCE232B),
                    ),
                    onTap: (){
                      Get.to(ItemView(),transition: Transition.topLevel,duration: Duration(seconds: 1));
                    },
                  ),
                  buildProjectCard(
                    context,
                    title: 'Order',
                    status: 'On-hold',
                    statusColor: const Color(0xFFCE232B),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // "Ongoing task" Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Text(
                'Ongoing task',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF000000),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Ongoing Task Card
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
            SizedBox(height: screenHeight * 0.03),
          ],
        ),
      ),
    );
  }

}