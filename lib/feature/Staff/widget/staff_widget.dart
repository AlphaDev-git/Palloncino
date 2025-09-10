import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/AddRequest/view/add_req_view.dart';
import 'package:pallon_app/feature/Calender/view/calender_view.dart';
import 'package:pallon_app/feature/Chat/view/chat_view.dart';
import 'package:pallon_app/feature/Profile/view/profile_view.dart';

import '../../../Core/Widgets/common_widgets.dart';
import '../../../models/user_model.dart';
import '../../Home/view/home_view.dart';
import '../../MainScreen/function/main_function.dart';


class StaffWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StaffWidget();
  }

}


class _StaffWidget extends State<StaffWidget>{
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  FirebaseAuth _auth=FirebaseAuth.instance;
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
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
    final List<Widget> _screens = [
      HomeView(), // Initial state for HomeView
      ChatView(),
      AddReqView(),
      CalenderView(),
      Profileview()
    ];
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:PageView(
        controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            // Animate to the selected page
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300), // Animation duration
              curve: Curves.slowMiddle, // Animation curve
            );
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF07933E),
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 48),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

}