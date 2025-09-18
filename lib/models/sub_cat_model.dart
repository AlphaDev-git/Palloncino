import 'package:pallon_app/models/catalog_item_model.dart';

class SubCatModel{
  String doc;
  String pic;
  String sub;
  List<CatalogItemModel> items=[];
  SubCatModel({required this.doc,required this.sub,required this.pic});
}