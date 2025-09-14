import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/items/function/item_action.dart';
import 'package:pallon_app/feature/items/view/edit_item_view.dart';
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
      stream: FirebaseFirestore.instance.collection("item").snapshots(),
      builder: (context, snapshot) {
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

        List<DataRow> rows = [];
        final messages = snapshot.data!.docs;
        for (var message in messages.reversed) {
          final data = message.data() as Map<String, dynamic>;
          ItemModel itemModel=ItemModel(
              doc: message.id, id: data['id'],
              name: data['Item'], count: int.parse(data['count']),price:double.parse(data['price']),pic: data['pic'],show: bool.parse(data['show']) );
          DataRow row = DataRow(
            cells: [
              DataCell(Text(data['id'].toString() ?? '')),
              DataCell(Text(data['Item'] ?? '')),
              DataCell(Text(data['count']?.toString() ?? '')),
              DataCell(Text(data['price']?.toString() ?? '')),
              DataCell(
                IconButton(
                  onPressed: () {
                    Get.to(EditItemView(itemModel),duration: Duration(seconds: 1),transition: Transition.topLevel);
                  },
                  icon: const Icon(Icons.edit_outlined),
                ),
              ),
            ],
          );
          rows.add(row);
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
                      'ID',
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
                      'Count',
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
                      'Price',
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
            ],
            rows: rows,
          ),
        );
      }
      );
      }