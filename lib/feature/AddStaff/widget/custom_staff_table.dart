import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/models/user_model.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;
final FirebaseAuth _auth=FirebaseAuth.instance;

Widget CustomeStaffTable(BuildContext context){
  final screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('user').where('type',isNotEqualTo: 'client').snapshots(),
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
            child: Text('No Staff found.'),
          );
        }
        List<DataRow> rows = [];
        List<UserModel> users=[];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed){
          if(message.id==_auth.currentUser!.uid){
          }
          else{
            users.add(
                UserModel(
                    doc: message.id, email: message.get('email'),
                    phone: message.get('phone'), name: message.get('name'),
                    pic: message.get('pic'), type: message.get('type'))
            );
            DataRow row=DataRow(
                cells: [
                  DataCell(Text(message.get('name'))),
                  DataCell(Text(message.get('email') ?? '')),
                  DataCell(Text(message.get('type'))),
                  DataCell(
                      IconButton(onPressed: ()async{
                        await _firestore.collection('user').doc(message.id).update({
                          'type':'client'
                        });
                      }, icon: Icon(Icons.delete))
                  ),
                ]
            );
            rows.add(row);
          }
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
              columnSpacing: screenWidth * 0.18,
              horizontalMargin: 16,
              dividerThickness: 2.0,
              showBottomBorder: true,
              sortAscending: true,
              columns: [
                DataColumn(
                  label: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Name',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Type',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: SizedBox(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Action',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
          ], rows: rows),
        );
      }
  );
}