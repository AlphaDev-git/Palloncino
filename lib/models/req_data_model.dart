import 'package:pallon_app/models/item_model.dart';

import 'catalog_item_model.dart';

class ReqDataModel{
  String doc;
  String address;
  String createby;
  String date;
  String deposite;
  String design;
  String fees;
  String float;
  String hour;
  String name;
  String notes;
  String ownerOfevent;
  String phone;
  String status;
  String total;
  String typeby;
  String typeOfBuilding;
  String typeOfEvent;
  List<String> des=[];
  List<CatalogItemModel> item=[];
  String typebank;
  String branch;
  ReqDataModel({required this.doc, required this.name,required this.fees,required this.total, required this.des,required this.item,
  required this.float,required this.address,required this.date,required this.hour,required this.phone,
  required this.createby,required this.deposite, required this.design,required this.notes,
  required this.ownerOfevent,required this.status,required this.typeby,required this.typeOfBuilding,
  required this.typeOfEvent,required this.branch,required this.typebank});
}