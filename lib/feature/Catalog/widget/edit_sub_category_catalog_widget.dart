import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/Catalog/Funcation/catalog_function.dart';
import 'package:pallon_app/models/sub_cat_model.dart';
import '../../../models/catalog_model.dart';


class EditSubCategoryCatalog extends StatefulWidget{
  Catalog catalog;
  SubCatModel sub;
  EditSubCategoryCatalog(this.catalog,this.sub);
  @override
  State<StatefulWidget> createState() {
    return _EditSubCategoryCatalog();
  }
}


class _EditSubCategoryCatalog extends State<EditSubCategoryCatalog>{
  File _image=File("");
  TextEditingController _name=TextEditingController();
  bool _show=false;
  @override
  void initState() {
    super.initState();
    _name=TextEditingController(text: widget.sub.sub);
  }
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: Colors.black,
                      child: _image.path != ""
                          ? ClipOval(
                        child: Image.file(
                          _image!,
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ) :ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.sub.pic,
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
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
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _show=true;
                        });
                        EditSubCategoryCatalogWidget(context, _image!, _name, widget.catalog, widget.sub);
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
                        'Update',
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