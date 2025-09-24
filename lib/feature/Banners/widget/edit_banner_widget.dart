import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/Banners/functions/banner_function.dart';
import 'package:pallon_app/models/banner_model.dart';

class EditBannerWidget extends StatefulWidget{
  BannerModel _bannerModel;
  EditBannerWidget(this._bannerModel);
  @override
  State<StatefulWidget> createState() {
    return _EditBannerWidget();
  }
}


class _EditBannerWidget extends State<EditBannerWidget> {
  String _typeaction="";
  bool _show = false;
  File? _image;
  File? _image2;
  TextEditingController _link = TextEditingController();
  @override
  void initState() {
    super.initState();
    _typeaction=widget._bannerModel.typeaction;
    if(_typeaction=="link"){
      _link=TextEditingController(text: widget._bannerModel.action);
    }
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
                          'Edit Banner',
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
                      ) : ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget._bannerModel.path,
                          width: screenWidth * 0.3,
                          height: screenWidth * 0.3,
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
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
                _typeaction=="same"?Text(""): _typeaction=="image"?Row(
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
                            ) :ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: widget._bannerModel.action,
                                width: screenWidth * 0.3,
                                height: screenWidth * 0.3,
                                fit: BoxFit.cover,
                              ),
                            )
                        )
                    ),
                  ],
                ):Padding(
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
                      onPressed: () {
                        if(_typeaction=="same"){
                          if(_image!=null){
                            setState(() {
                              _show=true;
                            });
                            UpdateSame(context, _image!, widget._bannerModel.doc);
                          }
                        }
                        else if(_typeaction=="image"){
                          if(_image!=null && _image2!=null){
                            setState(() {
                              _show=true;
                            });
                            UpdateImage3(context, _image!, _image2!, widget._bannerModel.doc);
                          }
                          else if(_image2!=null){
                            setState(() {
                              _show=true;
                            });
                            UpdateImage(context, _image2!, widget._bannerModel.doc);
                          }
                          else{
                            setState(() {
                              _show=true;
                            });
                            UpdateImage2(context, _image!, widget._bannerModel.doc);
                          }
                        }
                        else{
                          if(_image!=null && _link.text!=""){
                            setState(() {
                              _show=true;
                            });
                            UpdateLink3(context, widget._bannerModel.doc, _image!, _link);
                          }
                          else if(_image!=null){
                            setState(() {
                              _show=true;
                            });
                            UpdateLink2(context, widget._bannerModel.doc, _image!);
                          }
                          else{
                            setState(() {
                              _show=true;
                            });
                            UpdateLink(context, widget._bannerModel.doc, _link);
                          }
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
                        'Update Banner',
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
                        DeleteBanner(context, widget._bannerModel);
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
                        'Delete Banner',
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
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Image Selection'),
          backgroundColor: Colors.red,
        ),
      );
    }
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