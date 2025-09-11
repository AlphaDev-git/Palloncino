import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/items/function/item_action.dart';
import 'package:pallon_app/models/item_model.dart';

final FirebaseFirestore _firestore=FirebaseFirestore.instance;

Widget CustomeItemTable(BuildContext context){
  final screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection("item").snapshots(),
      builder: (context, snapshot){
        List<DataRow> rows = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final masseges = snapshot.data?.docs;
        for (var massege in masseges!.reversed){
          ItemModel itemModel=ItemModel(
              doc: massege.id, id: massege.get('id'),
              name: massege.get('Item'), count: int.parse(massege.get('count')));
          DataRow row = DataRow(
            cells: [
              DataCell(Text(massege.get('id'))),
              DataCell(Text(massege.get('Item'))),
              DataCell(Text(massege.get('count'))),
              DataCell(
                 IconButton(
                     onPressed: (){
                       EditItem(itemModel, context);
                     },
                     icon: Icon(Icons.edit_outlined))
              ),
            ],
          );
          rows.add(row);
        }
        return Center(
          child: DataTable(
              columnSpacing: screenWidth*0.18,
              horizontalMargin: 0,
              dividerThickness: 2.0,
              showBottomBorder: true,
              sortAscending: true,
              columns: [
                DataColumn(
                    label: SizedBox(
                      height: screenHeight * 0.08,
                      child: Center(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10),
                          child: Text('ID',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.035)),
                        ),
                      ),
                    )),
                DataColumn(
                    label: SizedBox(
                      height: screenHeight * 0.08,
                      child: Center(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10),
                          child: Text('Name',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.035)),
                        ),
                      ),
                    )),
                DataColumn(
                    label: SizedBox(
                      height: screenHeight * 0.08,
                      child: Center(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10),
                          child: Text('Count',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.035)),
                        ),
                      ),
                    )),
                DataColumn(
                    label: SizedBox(
                      height: screenHeight * 0.08,
                      child: Center(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10),
                          child: Text('Action',
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.035)),
                        ),
                      ),
                    )),
              ],
              rows: rows),
        );
      }
  );
}