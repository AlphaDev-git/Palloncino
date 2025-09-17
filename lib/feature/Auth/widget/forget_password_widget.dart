import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/Core/Widgets/common_widgets.dart';

import 'BottomWaveClipper.dart';
import 'TopWaveClipper.dart';



class ForgetPasswordWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ForgetPasswordWidget();
  }
}


class _ForgetPasswordWidget extends State<ForgetPasswordWidget>{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController _email=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _show=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.clear();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
        body: ModalProgressHUD(inAsyncCall: _show,
            child: Stack(
              children: [
                ClipPath(
                  clipper: TopWaveClipper(),
                  child: Container(
                    height: screenHeight * 0.45,
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: BottomWaveClipper(),
                    child: Container(
                      height: screenHeight * 0.65,
                      color: Colors.white,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.35),
                        Text(
                          'Forget Password',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF000000),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.07),
                        Text(
                          'Email',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.email_outlined),
                              hintText: 'demo@email.com',
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.02,
                                  horizontal: screenWidth * 0.05),
                            ),
                            keyboardType: TextInputType.emailAddress,
                              validator: (value){
                                if (value == null){
                                  return 'Please Enter Your Email';
                                }
                                return null;
                              }
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.13),
                        SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.07,
                          child: ElevatedButton(
                            onPressed:ResetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFCE232B),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              'Send Email',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  void ResetPassword()async{
    if (_formKey.currentState!.validate() && _email.text!="") {
      try{
        setState(() {
          _show=true;
        });
        await _auth.sendPasswordResetEmail(email: _email.text).whenComplete((){
          setState(() {
            _show=false;
          });
          Get.back();
        });
      }
      catch(e){
        print(e);
      }
    }
    else{
      ErrorCustom(context, "Please Enter Your Email");
    }
  }
}