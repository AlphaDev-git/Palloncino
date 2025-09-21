import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Catalog/widget/item_details_catalog_widget.dart';
import 'package:pallon_app/models/catalog_item_model.dart';


class ItemDetailsCatalogView extends StatelessWidget{
  CatalogItemModel itemModel;
  ItemDetailsCatalogView(this.itemModel);
  @override
  Widget build(BuildContext context) {
    return ItemDetailsCatalogWidget(itemModel);
  }
}