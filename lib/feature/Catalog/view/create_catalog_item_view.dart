import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/create_catalog_item_widget.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';

class CreateCatalogItemView extends StatelessWidget{
  Catalog cat;
  SubCatModel sub;
  SubSubCatModel subsub;
  CreateCatalogItemView(this.cat,this.sub,this.subsub);
  @override
  Widget build(BuildContext context) {
    return CreateCatalogItemWidget(cat,sub,subsub);
  }
}