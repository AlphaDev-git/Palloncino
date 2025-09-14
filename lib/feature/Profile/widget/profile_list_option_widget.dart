import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/AddStaff/view/add_staff_view.dart';
import 'package:pallon_app/feature/Profile/function/profile_function.dart';
import 'package:pallon_app/feature/items/view/item_view.dart';
import 'package:pallon_app/models/user_model.dart';

import 'custome_optione_tile.dart';
import 'update_profile_widget.dart';



List<Widget> CustomListOptions(BuildContext context,UserModel user){
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  List<Widget> admin=[
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Update Profile', Icons.person_outline,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Add New Staff', Icons.person_add_alt,
            () =>Get.to(AddStaffView(),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Items', Icons.storefront_sharp,
            () =>Get.to(ItemView(),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Language', Icons.language,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Terms of Use', Icons.description_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Privacy Policy', Icons.privacy_tip_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Remove Account', Icons.remove_circle_outline,
            () =>RemoveAccount(context)),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Logout', Icons.logout_outlined,
            () =>logout(context)),
  ];
  List<Widget> client=[
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Update Profile', Icons.person_outline,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Language', Icons.language,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Terms of Use', Icons.description_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Privacy Policy', Icons.privacy_tip_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Logout', Icons.logout_outlined,
            () =>logout(context)),
  ];
  List<Widget> staff=[
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Update Profile', Icons.person_outline,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Language', Icons.language,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Terms of Use', Icons.description_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Privacy Policy', Icons.privacy_tip_outlined,
            () =>Get.to(UpdateProfileWidget(user),transition: Transition.topLevel,
            duration: Duration(seconds: 1))),
    SizedBox(height: screenHeight * 0.01),
    buildOptionTile(context, 'Logout', Icons.logout_outlined,
            () =>logout(context)),
  ];
  return user.type=="Admin"?admin:
  user.type=="staff"?staff:
  client;
}