import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/feature/AddRequest/functions/req_function.dart';
import 'package:pallon_app/models/item_model.dart';
import 'package:pallon_app/models/req_model.dart';
import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';


class CompeleteReqWidget extends StatefulWidget{
  ReqModel req;
  CompeleteReqWidget(this.req);
  @override
  State<StatefulWidget> createState() {
    return _CompeleteReqWidget();
  }

}


class _CompeleteReqWidget extends State<CompeleteReqWidget>{
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  FirebaseAuth _auth=FirebaseAuth.instance;
  double _totlaprice=0.0;
  bool _AddDesgin=false;
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  List<ItemModel>_allItems=[];
  List<ItemModel> _selectedItems = [];
  ItemModel? _selectedItem;
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _deposit=TextEditingController();
  bool _showModel=false;
  @override
  void initState() {
    super.initState();
    _deposit=TextEditingController(
      text: "0.0"
    );
    GetUserType();
    GetAllItems();
  }
  void GetUserType()async{
    userModel =await GetUserData(_auth.currentUser!.uid);
    setState(() {
      userModel;
    });
  }
  void GetAllItems()async{
    _allItems=await GetItemsList();
    setState(() {
      _allItems;
    });
  }
  void _addItemToTable() {
    if (_formKey.currentState!.validate() && _selectedItem != null) {
      final count = int.tryParse(_countController.text);
      double price=_selectedItem!.price*count!;
      if (count != null && count > 0) {
        setState(() {
          _selectedItems.add(ItemModel(
            id: _selectedItem!.id,
            name: _selectedItem!.name,
            count: count,
            price: _selectedItem!.price,
            show: _selectedItem!.show,
            pic: _selectedItem!.pic,
            doc: _selectedItem!.doc,
          ));
          _totlaprice+=price;
        });
        _countController.clear();
        _selectedItem = null;
      }
    }
  }
  Future<void> _pickImage() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((xFile) => File(xFile.path)));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double appBarTitleFontSize = screenWidth * 0.045;
    double appBarLeadingPadding = screenWidth * 0.02;
    double appBarLeadingBorderRadius = screenWidth * 0.06;
    double appBarLeadingIconSize = screenWidth * 0.06;
    double titleSectionFontSize = screenWidth * 0.06;
    double titleSectionSpacing = screenHeight * 0.025;
    double formPadding = screenWidth * 0.04;
    double imagePickerHeight = screenHeight * 0.2;
    double imagePickerBorderWidth = screenWidth * 0.005;
    double imagePickerBorderRadius = screenWidth * 0.025;
    double uploadIconSize = screenWidth * 0.15;
    double uploadTextSpacing = screenHeight * 0.01;
    double uploadTextFontSize = screenWidth * 0.04;
    double imagePreviewWidth = screenWidth * 0.4;
    double imagePreviewMargin = screenWidth * 0.02;
    double imagePreviewBorderRadius = screenWidth * 0.02;
    double removeImageButtonPadding = screenWidth * 0.01;
    double removeImageButtonIconSize = screenWidth * 0.04;
    double formFieldSpacing = screenHeight * 0.02;
    double dropdownItemFontSize = screenWidth * 0.038;
    double submitButtonSpacing = screenHeight * 0.03;
    double submitButtonVerticalPadding = screenHeight * 0.02;
    double submitButtonBorderRadius = screenWidth * 0.025;
    double submitButtonFontSize = screenWidth * 0.05;
    for (var item in _selectedItems) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(item.name)),
          DataCell(Text(item.count.toString())),
          DataCell(
            item.show?  Text(item.price.toString()):Text("No Price")
          ),
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete_outlined, color: Color(0xFFCE232B)),
              onPressed: () {
                setState(() {
                  _selectedItems.remove(item);
                });
              },
            ),
          ),
        ],
      ));
    }
    return  Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Complete Request', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showModel,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Item Selection Dropdown
                      DropdownButtonFormField<ItemModel>(
                        decoration: const InputDecoration(
                          labelText: 'Select Item',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        value: _selectedItem,
                        items: _allItems.map((ItemModel item) {
                          return DropdownMenuItem<ItemModel>(
                            value: item,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (ItemModel? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select an item';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Quantity Input
                      TextFormField(
                        controller: _countController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a quantity';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        onPressed: _addItemToTable,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF07933E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Add Item',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                // Items Table
                _buildItemTable(context),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Text("Add Special Desgin"),Checkbox(value: _AddDesgin, onChanged: (value){
                      setState(() {
                        _AddDesgin=!_AddDesgin;
                      });
                    }),
                  ],
                ),
               _AddDesgin?Container(
                 height: imagePickerHeight,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(imagePickerBorderRadius),
                   border: Border.all(
                     color: Colors.grey.shade400,
                     style: BorderStyle.solid,
                     width: imagePickerBorderWidth,
                   ),
                 ),
                 child: GestureDetector(
                   onTap: _pickImage,
                   child: _images.isEmpty
                       ? Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Icon(Icons.upload),
                         SizedBox(height: uploadTextSpacing),
                         Text(
                           "Upload Images",
                           style: TextStyle(
                             fontSize: uploadTextFontSize,
                             color: Colors.grey.shade600,
                             fontFamily: 'Tajawal',
                           ),
                         ),
                       ],
                     ),
                   )
                       : SizedBox(
                     height: imagePickerHeight,
                     child: ListView.builder(
                       scrollDirection: Axis.horizontal,
                       itemCount: _images.length,
                       itemBuilder: (context, index) {
                         return Stack(
                           children: [
                             Container(
                               width: imagePreviewWidth,
                               margin: EdgeInsets.all(imagePreviewMargin),
                               decoration: BoxDecoration(
                                 borderRadius:
                                 BorderRadius.circular(imagePreviewBorderRadius),
                                 image: DecorationImage(
                                   image: FileImage(_images[index]),
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ),
                             Positioned(
                               top: screenWidth * 0.01,
                               right: screenWidth * 0.01,
                               child: InkWell(
                                 onTap: () => _removeImage(index),
                                 child: Container(
                                   padding: EdgeInsets.all(removeImageButtonPadding),
                                   decoration: BoxDecoration(
                                     color: Colors.red,
                                     shape: BoxShape.circle,
                                   ),
                                   child: Icon(Icons.close,
                                       size: removeImageButtonIconSize,
                                       color: Colors.white),
                                 ),
                               ),
                             ),
                           ],
                         );
                       },
                     ),
                   ),
                 ),
               )
                   : Text(""),
                const SizedBox(height: 32),
                Text("Notes"),
                TextFormField(
                  controller: _notes,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                userModel.type=="client"?Text(""):Text("Deposit"),
                userModel.type=="client"?Text(""):TextFormField(
                  controller: _deposit,
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
                          _showModel=true;
                        });
                        double fees=_totlaprice - double.parse(_deposit.text);
                        if(_AddDesgin){
                          Submit2(userModel, _AddDesgin, widget.req,
                              _images, _selectedItems, _notes.text, double.parse(_deposit.text), fees, _totlaprice);
                        }
                        else{
                          Submit(userModel, _AddDesgin, widget.req, _selectedItems,
                              _notes.text, double.parse(_deposit.text),
                              fees, _totlaprice);
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
                        "Price $_totlaprice",
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
  Widget _buildItemTable(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<DataRow> rows = [];
    for (var item in _selectedItems) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(item.name)),
          DataCell(Text(item.count.toString())),
          DataCell(Text(item.price.toString())),
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete_outlined, color: Color(0xFFCE232B)),
              onPressed: () {
                setState(() {
                  double price=item.price*item.count;
                  _totlaprice-=price;
                  _selectedItems.remove(item);
                });
              },
            ),
          ),
        ],
      ));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: screenWidth * 0.15,
        horizontalMargin: 10,
        dividerThickness: 2.0,
        showBottomBorder: true,
        sortAscending: true,
        columns: [
          _buildDataColumn('Name', screenWidth),
          _buildDataColumn('Count', screenWidth),
          _buildDataColumn('Price', screenWidth),
          _buildDataColumn('Action', screenWidth),
        ],
        rows: rows,
      ),
    );
  }
  DataColumn _buildDataColumn(String label, double screenWidth) {
    return DataColumn(
      label: SizedBox(
        height: 40,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF07933E),
            ),
          ),
        ),
      ),
    );
  }

}