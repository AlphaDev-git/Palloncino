import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Client/view/client_main_view.dart';
import 'package:pallon_app/feature/MainScreen/function/main_function.dart';
import 'package:pallon_app/feature/Staff/view/staff_view.dart';
import 'package:pallon_app/models/user_model.dart';


class MainScreenWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainScreenWidget();
  }

}


class _MainScreenWidget extends State<MainScreenWidget>{
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  FirebaseAuth _auth=FirebaseAuth.instance;
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
    return userModel!.type=="client"?ClientMainView():StaffView();
  }

}