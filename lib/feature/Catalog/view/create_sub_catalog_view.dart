import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/create_sub_catalog_widget.dart';
import 'package:pallon_app/models/catalog_model.dart';

class CreateSubCatalogView extends StatelessWidget{
  Catalog cat;
  CreateSubCatalogView(this.cat);
  @override
  Widget build(BuildContext context) {
    return CreateSubCatalogWidget(cat);
  }
}