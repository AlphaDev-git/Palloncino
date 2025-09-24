import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Banners/widget/edit_banner_widget.dart';
import 'package:pallon_app/models/banner_model.dart';


class EditBannerView extends StatelessWidget{
  BannerModel _bannerModel;
  EditBannerView(this._bannerModel);
  @override
  Widget build(BuildContext context) {
    return EditBannerWidget(_bannerModel);
  }
}