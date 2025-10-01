import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/req_data_model.dart';



Widget ReqDataTableDetails(ReqDataModel req,BuildContext context){
  List<DataRow> rows = [];
  final screenHeight = MediaQuery
      .of(context)
      .size
      .height;
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  for (var item in req.item){
    rows.add(
      DataRow(cells: [
        DataCell(Text(item.name)),
        DataCell(Text(item.price.toString())),
        DataCell(Text(item.des.toString())),
      ])
    );
  }
  return DataTable(
    sortAscending: true,
      showBottomBorder: true,
      columns: [
    _buildDataColumn('Name', screenWidth),
    _buildDataColumn('Price', screenWidth),
        _buildDataColumn('Notes', screenWidth),
  ], rows: rows);
}
DataColumn _buildDataColumn(String label, double screenWidth) {
  return DataColumn(
    label: SizedBox(
      width: screenWidth*0.18,
      height: 40,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF07933E),
          ),
        ),
      ),
    ),
  );
}