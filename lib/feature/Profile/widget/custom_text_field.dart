import 'package:flutter/material.dart';


Widget buildTextField(BuildContext context, {
  required String label,
  required IconData icon,
  required TextEditingController controller,
}) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.045,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF000000),
        ),
      ),
      SizedBox(height: screenHeight * 0.01),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey[700]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.05),
        ),
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: const Color(0xFF000000),
        ),
      ),
    ],
  );
}