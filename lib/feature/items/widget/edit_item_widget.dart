import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallon_app/models/item_model.dart';

import '../function/item_action.dart';


class EditItemWidget extends StatefulWidget{
  ItemModel itemModel;
  EditItemWidget(this.itemModel);
  @override
  State<StatefulWidget> createState() {
    return _EditItemWidget();
  }

}


class _EditItemWidget extends State<EditItemWidget>{
  TextEditingController id=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController price=TextEditingController();
  String doc="";
  File? _image;
  bool _showprice=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showprice=widget.itemModel.show;
    doc=widget.itemModel.doc;
    price=TextEditingController(
      text: widget.itemModel.price.toString()
    );
    id=TextEditingController(
      text: widget.itemModel.id
    );
    name=TextEditingController(
      text: widget.itemModel.name
    );
    number=TextEditingController(
      text: widget.itemModel.count.toString()
    );
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
      body: SingleChildScrollView(
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
                        color: Colors.black,
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
                      imageUrl: widget.itemModel.pic,
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
                    'ID',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: id,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.qr_code),
                      hintText: 'ID OF Item',
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
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: name,
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
                    controller: price,
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
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Count',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    controller: number,
                    obscureText: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      hintText: 'Count OF Item',
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
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    children: [
                      Text(
                        'Show Price',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Checkbox(value: _showprice, onChanged: (value){
                        setState(() {
                          _showprice=!_showprice;
                        });
                      })
                    ],
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
                  onPressed: () {
                    if(_image!=null){
                      widget.itemModel=ItemModel(
                          doc: doc, id: id.text, name: name.text, count: int.parse(number.text), price: double.parse(price.text),
                          pic: "", show: _showprice);
                      EditItemAction(widget.itemModel,_image!, context);
                    }
                    else{
                      String pic =widget.itemModel.pic;
                      widget.itemModel=ItemModel(
                          doc: doc, id: id.text, name: name.text, count: int.parse(number.text), price: double.parse(price.text),
                          pic: pic, show: _showprice);
                      EditItemAction2(widget.itemModel, context);
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
                    RemoveItem(widget.itemModel, context);
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