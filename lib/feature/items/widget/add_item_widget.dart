import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pallon_app/feature/items/function/item_action.dart';
import 'package:pallon_app/models/item_model.dart';



class AddItemWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddItemWidget();
  }

}


class _AddItemWidget extends State<AddItemWidget>{
  TextEditingController id=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();
  TextEditingController price=TextEditingController();
  File? _image;
  bool _showprice=false;
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
                      'Add New Item',
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
                ) :Icon(
                  Icons.storefront_sharp,
                  size: screenWidth * 0.15,
                  color: Colors.grey[300],
                ),
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
                    ItemModel item=ItemModel(
                        doc: "", id: id.text, name: name.text, count: int.parse(number.text), price: double.parse(price.text),
                        pic: "", show: _showprice);
                    SaveNewItem(item,_image!, context);
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
                    'Add Item',
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