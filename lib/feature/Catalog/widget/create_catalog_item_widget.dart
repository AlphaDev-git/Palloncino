import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/Catalog/Funcation/catalog_function.dart';
import 'package:pallon_app/models/catalog_model.dart';
import 'package:pallon_app/models/sub_cat_model.dart';

import '../../../models/sub_sub_cat.dart';



class CreateCatalogItemWidget extends StatefulWidget{
  Catalog cat;
  SubCatModel sub;
  SubSubCatModel subsub;
  CreateCatalogItemWidget(this.cat,this.sub,this.subsub);
  @override
  State<StatefulWidget> createState() {
    return _CreateCatalogItemWidget();
  }
}


class _CreateCatalogItemWidget extends State<CreateCatalogItemWidget>{
  TextEditingController _name=TextEditingController();
  TextEditingController _des=TextEditingController();
  TextEditingController _price=TextEditingController();
  File? _image;
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
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: _name,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.text_fields),
                          hintText: 'Name OF Item',
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
                SizedBox(height: screenHeight * 0.09),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: _des,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.text_fields),
                          hintText: 'Description OF Item',
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
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      TextFormField(
                        controller: _price,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.text_fields),
                          hintText: 'Price OF Item',
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
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.09),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _show=true;
                        });
                        CreateCatalogItems(context, widget.cat, widget.sub,widget.subsub, _name, _des, _price, _image!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCE232B),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(screenWidth * 0.05),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'Add New Item',
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
}