import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallon_app/models/user_model.dart';
import '../function/profile_function.dart';
import 'custom_text_field.dart';

class UpdateProfileWidget extends StatefulWidget{
  UserModel userModel;
  UpdateProfileWidget(this.userModel);
  @override
  State<StatefulWidget> createState() {
    return _UpdateProfileWidget();
  }

}

class _UpdateProfileWidget extends State<UpdateProfileWidget>{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    if(widget.userModel.name==""||widget.userModel.name=="name"){
      _nameController.text = 'No Name';
    }
    else{
      _nameController.text = widget.userModel.name;
    }
    _phoneController.text = widget.userModel.phone;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image selection simulated!'),
        backgroundColor: Color(0xFF07933E),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header with Green Gradient
            Container(
              height: screenHeight * 0.35,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF07933E),
                    Color(0xFF007530),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: screenHeight * 0.08,
                    left: screenWidth * 0.08,
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: screenHeight * 0.03),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundColor: Colors.white,
                              child: _image != null
                                  ? ClipOval(
                                child: Image.file(
                                  _image!,
                                  width: screenWidth * 0.3,
                                  height: screenWidth * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ) :widget.userModel.pic!=""||widget.userModel.pic!="pic"?
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: widget.userModel.pic,
                                  width: screenWidth * 0.3,
                                  height: screenWidth * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  :Icon(
                                Icons.person,
                                size: screenWidth * 0.15,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            _nameController.text,
                            style: TextStyle(
                              fontSize: screenWidth * 0.055,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            widget.userModel.type, // Placeholder for user's job title
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            // Editable Profile Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(
                    context,
                    label: 'Full Name',
                    icon: Icons.person_outline,
                    controller: _nameController,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  buildTextField(
                    context,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    controller: _phoneController,
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // Update Profile Button
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: (){
                        updateProfile(_nameController.text,_phoneController.text,_image!,context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCE232B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.05),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}