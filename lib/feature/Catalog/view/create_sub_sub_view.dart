import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/create_sub_sub_widget.dart';

import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';


class CreateSubSubView extends StatelessWidget{
  SubCatModel sub;
  Catalog catalog;
  CreateSubSubView(this.catalog,this.sub);
  @override
  Widget build(BuildContext context) {
    return CreateSubSubWidget(this.catalog,this.sub);
  }
}