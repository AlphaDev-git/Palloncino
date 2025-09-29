import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Profile/function/profile_function.dart';
import 'package:pallon_app/feature/Profile/widget/custom_text_field.dart';

import '../../../Core/Widgets/common_widgets.dart';



class UpdatePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _UpdatePassword();
  }
}

class _UpdatePassword extends State<UpdatePassword>{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController _currentpassword=TextEditingController();
  TextEditingController _newpassword=TextEditingController();
  TextEditingController _confirmpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                      'Update Password',
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
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(children: [
               SizedBox(height: screenHeight*0.02,),
               buildTextField(context,
                   label: "Enter New Password", icon: Icons.password,
                   controller: _newpassword
               ),
               SizedBox(height: screenHeight*0.02,),
               buildTextField(context,
                   label: "Confirm New Password", icon: Icons.password,
                   controller: _confirmpassword
               )
             ],),
           ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: ElevatedButton(
                  onPressed: (){
                    if(_newpassword.text!=""){
                      if(_confirmpassword.text!=""){
                        if(_newpassword.text==_confirmpassword.text){
                          UpdatePasswordProfile(_newpassword, context);
                        }
                        else{
                          showErrorDialog(context, "Passwords Not match");
                        }
                      }
                      else{
                        showErrorDialog(context, "Please Confirm New Password");
                      }
                    }
                    else{
                      showErrorDialog(context, "Please Enter New Password");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF07933E),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(screenWidth * 0.05),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Update Your Password',
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}