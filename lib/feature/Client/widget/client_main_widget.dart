import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/AddRequest/view/add_req_view.dart';
import 'package:pallon_app/feature/Client/view/client_home_view.dart';
import 'package:pallon_app/feature/Profile/view/profile_view.dart';

import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';


class ClientMainWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClientMainWidget();
  }

}


class _ClientMainWidget extends State<ClientMainWidget>{
  int currentIndex = 0;
  List<Widget> views = [
    ClientHomeView(),
    AddReqView(),
    Profileview()
  ];
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
    return Scaffold(
      body: views[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
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
            icon: Icon(Icons.add_circle, size: 48),
            label: 'Add',
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