import 'package:flutter/material.dart';
import 'package:pallon_app/feature/items/widget/edit_item_widget.dart';
import 'package:pallon_app/models/item_model.dart';


class EditItemView extends StatelessWidget{
  ItemModel itemModel;
  EditItemView(this.itemModel);
  @override
  Widget build(BuildContext context) {
    return EditItemWidget(itemModel);
  }
}