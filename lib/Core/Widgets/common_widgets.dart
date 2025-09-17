import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/feature/projects/view/project_view.dart';


Widget buildProjectCard(BuildContext context,
    {required String title,
      required String status,
      required Color statusColor}) {
  final screenWidth = MediaQuery.of(context).size.width;
  return InkWell(
    // onTap: (){
    //   //Get.to(ProjectView(),transition: Transition.cupertinoDialog,duration: Duration(seconds: 1));
    // },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF000000),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: const Color(0xFFCE232B),
                size: screenWidth * 0.04,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildAvatar({bool isMore = false, int count = 0}) {
  return Container(
    width: 24,
    height: 24,
    decoration: BoxDecoration(
      color: isMore ? const Color(0xFFCE232B) : Colors.white,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
    ),
    child: isMore
        ? Center(
      child: Text(
        '+$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    )
        : null, // For simplicity, we're not using a real image.
  );
}


void ErrorCustom(BuildContext context,String text){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    ),
  );
}