import 'package:pallon_app/models/catalog_item_model.dart';

class SubSubCatModel{
  String doc;
  String subsub;
  String pic;
  List<CatalogItemModel> items=[];
  SubSubCatModel({required this.doc,required this.subsub,required this.pic});
}