import 'package:flutter/material.dart';
import 'package:pallon_app/models/catalog_item_model.dart';


class ItemDetailsCatalogWidget extends StatefulWidget{
  CatalogItemModel itemModel;
  ItemDetailsCatalogWidget(this.itemModel);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemDetailsCatalogWidget();
  }
}


class _ItemDetailsCatalogWidget extends State<ItemDetailsCatalogWidget>{
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

}