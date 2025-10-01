import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/item_details_catalog_widget.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';

import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';


class ItemDetailsCatalogView extends StatelessWidget{
  Catalog cat;
  SubCatModel sub;
  SubSubCatModel subsub;
  CatalogItemModel itemModel;
  ItemDetailsCatalogView(this.cat,this.sub,this.subsub,this.itemModel);
  @override
  Widget build(BuildContext context) {
    return ItemDetailsCatalogWidget(cat,sub,subsub,itemModel);
  }
}