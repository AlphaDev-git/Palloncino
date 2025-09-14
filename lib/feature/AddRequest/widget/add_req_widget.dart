import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/AddRequest/view/complete_req_view.dart';
import 'package:pallon_app/models/req_model.dart';


class AddReqWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddReqWidget();
  }

}


class _AddReqWidget extends State<AddReqWidget>{
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController type=TextEditingController();
  TextEditingController nameofevent=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController typeofbuilding=TextEditingController();
  TextEditingController float=TextEditingController();
  TextEditingController hour=TextEditingController();
  TextEditingController date=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    phone.dispose();
    type.dispose();
    nameofevent.dispose();
    address.dispose();
    typeofbuilding.dispose();
    float.dispose();
    hour.dispose();
    date.dispose();
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
          mainAxisSize: MainAxisSize.min,
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
                            'New Request',
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.004),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: name,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: phone,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Type Of Event',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: type,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Owner Of Event',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: nameofevent,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Hour',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: hour,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: date,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: address,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'type of building',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: typeofbuilding,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Float',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: float,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.07,
                child: ElevatedButton(
                  onPressed: () {
                    ReqModel req=ReqModel(
                        Name: name.text, Phone: phone.text,
                        TypeOfEvent: type.text,
                        OwnerOfEvent: nameofevent.text,
                        Hour: hour.text.toString(), Date: date.text.toString(),
                        Address: address.text,
                        TypeOfBuilding: typeofbuilding.text, Float: float.text);
                    name.clear();
                    phone.clear();
                    type.clear();
                    nameofevent.clear();
                    address.clear();
                    typeofbuilding.clear();
                    float.clear();
                    hour.clear();
                    date.clear();
                   Get.to(CompeleteReqView(req),transition: Transition.rightToLeft,duration: Duration(seconds: 1));
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
                    'Next',
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