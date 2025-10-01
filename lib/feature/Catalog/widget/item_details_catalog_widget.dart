import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/Catalog/Funcation/catalog_function.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/sub_sub_cat.dart';
import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';


class ItemDetailsCatalogWidget extends StatefulWidget{
  Catalog cat;
  SubCatModel sub;
  SubSubCatModel subsub;
  CatalogItemModel itemModel;
  ItemDetailsCatalogWidget(this.cat,this.sub,this.subsub,this.itemModel);
  @override
  State<StatefulWidget> createState() {
    return _ItemDetailsCatalogWidget();
  }
}


class _ItemDetailsCatalogWidget extends State<ItemDetailsCatalogWidget>{
  TextEditingController _name=TextEditingController();
  TextEditingController _des=TextEditingController();
  TextEditingController _price=TextEditingController();
  File? _image;
  bool _show=false;
  @override
  void initState() {
    super.initState();
    _name=TextEditingController(text: widget.itemModel.name);
    _des=TextEditingController(text: widget.itemModel.des);
    _price=TextEditingController(text: widget.itemModel.price);
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ModalProgressHUD(
        inAsyncCall: _show,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.19,
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
                        'Edit Item',
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
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
                    ) :ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: widget.itemModel.path,
                        width: screenWidth * 0.3,
                        height: screenWidth * 0.3,
                        fit: BoxFit.cover,
                      ),
                    )
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
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
                    SizedBox(height: screenHeight * 0.04),
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
                    SizedBox(height: screenHeight * 0.04),
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
                        prefixIcon: const Icon(Icons.monetization_on),
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
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _show=true;
                            });
                            if(_image!=null){
                              EditItemCataglog2(context, _name, _des, _price,
                                  widget.itemModel.doc, widget.cat, widget.sub,_image!,widget.subsub);
                            }
                            else{
                              EditItemCataglog(context, _name, _des, _price,
                                  widget.itemModel.doc, widget.cat, widget.sub,widget.subsub);
                            }
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
                            'Save Edit Item',
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _show=true;
                            });
                            DeleteItemCatalog(context, widget.itemModel.doc,
                                widget.cat, widget.sub,widget.subsub);
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
                            'Delete Item',
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
              )
            ],
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image selection simulated!'),
          backgroundColor: Color(0xFF07933E),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Image Selection'),
          backgroundColor: Colors.red,
        ),
      );
    }


  }

}