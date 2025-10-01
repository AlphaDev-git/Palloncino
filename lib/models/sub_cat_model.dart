import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';

class SubCatModel{
  String doc;
  String pic;
  String sub;
  List<SubSubCatModel> subsub=[];
  List<CatalogItemModel> items=[];
  SubCatModel({required this.doc,required this.sub,required this.pic});
}