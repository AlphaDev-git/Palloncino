import 'package:pallon_app/models/sub_cat_model.dart';

class Catalog{
  String cat;
  String doc;
  String pic;
  List<SubCatModel> sub=[];
  Catalog({required this.doc,required this.cat,required this.pic});
}