import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/Core/Widgets/common_widgets.dart';
import 'package:pallon_app/feature/Banners/functions/banner_function.dart';



class AddBannerWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddBannerWidget();
  }
}

class _AddBannerWidget extends State<AddBannerWidget>{
  TextEditingController _link=TextEditingController();
  File? _image;
  String _typeaction = 'same';
  File? _image2;
  bool _show=false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return ModalProgressHUD(
      inAsyncCall: _show,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                            radius: screenWidth * 0.15,
                            backgroundColor: Colors.black,
                            child: _image != null
                                ? ClipOval(
                              child: Image.file(
                                _image!,
                                width: screenWidth * 0.3,
                                height: screenWidth * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ) :Icon(
                              Icons.image,
                              size: screenWidth * 0.15,
                              color: Colors.grey[300],
                            )
                        )
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Action",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: 'Tajawal'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: DropdownButtonFormField<String>(
                    value: _typeaction,
                    items: <String>['same', 'image','link'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _typeaction = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select action';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                _typeaction=="same"?Text(""):
                _typeaction=="image"?Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: _pickImage2,
                        child: CircleAvatar(
                            radius: screenWidth * 0.15,
                            backgroundColor: Colors.black,
                            child: _image2 != null
                                ? ClipOval(
                              child: Image.file(
                                _image2!,
                                width: screenWidth * 0.3,
                                height: screenWidth * 0.3,
                                fit: BoxFit.cover,
                              ),
                            ) :Icon(
                              Icons.image,
                              size: screenWidth * 0.15,
                              color: Colors.grey[300],
                            )
                        )
                    ),
                  ],
                ):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Link',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: _link,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.link),
                          hintText: 'Url link',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02,
                              horizontal: screenWidth * 0.05),
                        ),
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_image!=null){
                          if(_typeaction=="same"){
                            setState(() {
                              _show=true;
                            });
                            AddBannerSame(context, _image!);
                          }
                          else if(_typeaction=="image"){
                            if(_image2!=null){
                              setState(() {
                                _show=true;
                              });
                              AddBannerImage(context, _image!, _image2!);
                            }
                            else{
                              showErrorDialog(context, "Please Upload Secound Image");
                            }
                          }
                          else{
                            if(_link.text!=""){
                              setState(() {
                                _show=true;
                              });
                              AddBannerLink(context, _image!, _link);
                            }
                            else{
                              showErrorDialog(context, "Please Enter Url");
                            }
                          }
                        }
                        else{
                          showErrorDialog(context, "Please Upload Image");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF07933E),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.05),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Add New Banner',
                        style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
  void _pickImage2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image2 = File(pickedFile.path);
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Image selection simulated!'),
        backgroundColor: Color(0xFF07933E),
      ),
    );
  }
}