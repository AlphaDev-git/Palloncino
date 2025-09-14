import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Requset/Widget/req_card.dart';
import 'package:pallon_app/models/req_data_model.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;
Widget CustomListReq(BuildContext context){
  final screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('req').snapshots(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF07933E),
            ),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No items found.'),
          );
        }
        List<ReqDataModel> lists=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          lists.add(ReqDataModel(doc:message.id ,name: message.get('name'), fees: message.get('fees'), total: message.get('total'),
              des: [], item: [], float: message.get('float'), address: message.get('address'),
              date: message.get('date'), hour: message.get('hour'), phone: message.get('phone'),
              createby: message.get('createby'),
              deposite: message.get('deposit'), design: message.get('desgin'), notes: message.get('notes'),
              ownerOfevent: message.get('ownerofevent'),
              status: message.get('status'), typeby: message.get('typeCreate'), typeOfBuilding: message.get('typeofbuilding'),
              typeOfEvent: message.get('typeofevent')));
        }
        return ListView.builder(
            itemCount: lists.length,
            itemBuilder: (context,index){
              return buildReqCard(context, lists[index]);
            }
        );
      }
  );
}