import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/Auth/function/Auth_Functions.dart';
import 'package:pallon_app/feature/Auth/view/auth_signup_view.dart';
import 'package:pallon_app/feature/Auth/view/forget_password_view.dart';
import '../../../Core/Widgets/common_widgets.dart';
import 'BottomWaveClipper.dart';
import 'TopWaveClipper.dart';


class AuthSignInWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _AuthSignInWidget();
  }
  
}

class _AuthSignInWidget extends State<AuthSignInWidget>{
  TextEditingController _email=TextEditingController();
  TextEditingController _pass=TextEditingController();
  bool _show=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.clear();
    _pass.clear();
    _show=false;
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _show,
        child: Stack(
          children: [
            // Green Wavy Background
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
            // White Wavy Foreground
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
            // Login Form and Content
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.35),
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: screenWidth * 0.1,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    // Email Field
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Password Field
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    TextFormField(
                      controller: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        hintText: 'enter your password',
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
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: true,
                              onChanged: (value) {},
                              fillColor: MaterialStateProperty.all(
                                  const Color(0xFFCE232B)),
                              visualDensity: VisualDensity.compact,
                            ),
                            Text('Remember Me',
                                style: TextStyle(fontSize: screenWidth * 0.035)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(ForgetPasswordView(),transition: Transition.fadeIn,duration: Duration(seconds: 1));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: const Color(0xFFCE232B),
                                fontSize: screenWidth * 0.035),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if(_email!=""){
                            if(_pass!=""){
                              setState(() {
                                _show=true;
                              });
                              SignInMethod(_email.text, _pass.text, context);
                              setState(() {
                                _show=false;
                              });
                            }
                            else{
                              ErrorCustom(context, "Please Enter Your Name");
                            }
                          }
                          else{
                            ErrorCustom(context, "Please Enter Your Name");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFCE232B),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.05),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    // Sign Up Link
                    InkWell(
                      onTap: (){
                        Get.to(AuthSignupView(),transition: Transition.cupertino,duration: Duration(seconds: 1));
                      },
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an Account? ",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: screenWidth * 0.04,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Sign up',
                                style: TextStyle(
                                  color: const Color(0xFFCE232B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}