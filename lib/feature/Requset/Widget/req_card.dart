import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/Requset/Widget/req_details_widget.dart';
import 'package:pallon_app/models/req_data_model.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;
Widget buildReqCard(BuildContext context,ReqDataModel req){
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  double progress=double.parse(req.deposite)/double.parse(req.total);
  return InkWell(
    onTap: (){
      Get.to(ReqDetailsWidget(req),transition: Transition.zoom,duration: Duration(seconds: 1));
    },
    child: Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.015,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    req.typeOfEvent,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        req.status,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.15,
                            height: screenWidth * 0.15,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 8,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  (progress > 0.5) ? const Color(0xFF07933E) : const Color(0xFFCE232B)),
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            req.name,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            req.address,
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.black,
                            ),
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
                            req.date,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                 req.status=="inreview"? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(onPressed: ()async{
                        await _firestore.collection('req').doc(req.doc).update({
                          'status':'active',
                        });
                      },style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF07933E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 33),
                        elevation: 5,
                      ), child: Text("Accept",style: TextStyle(color: Colors.white),)),
                      ElevatedButton(onPressed: ()async{
                        await _firestore.collection('req').doc(req.doc).delete();
                      }, style: ElevatedButton.styleFrom(
                        backgroundColor:  Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 33),
                        elevation: 5,
                      ),child: Text("Reject",style: TextStyle(color: Colors.white),)),
                    ],
                  ):ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                   backgroundColor:  const Color(0xFF07933E),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15.0),
                   ),
                   padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 33),
                   elevation: 5,
                 ), child: Text("Jop Order",style: TextStyle(color: Colors.white),))
                ],
              )
          )
        ],
      ),
    ),
  );
}