import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Home/widget/home_widget.dart';

import '../../../models/user_model.dart';

class HomeView extends StatelessWidget{
  UserModel userModel;
  HomeView(this.userModel);
  @override
  Widget build(BuildContext context) {
    return HomeWidget(userModel);
  }

}