import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/subsub_widget.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';

class SubSubView extends StatelessWidget{
  SubCatModel sub;
  Catalog catalog;
  SubSubView(this.catalog,this.sub);
  @override
  Widget build(BuildContext context) {
    return SubSubWidget(this.catalog,this.sub);
  }
}