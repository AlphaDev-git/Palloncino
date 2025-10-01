import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pallon_app/Core/Widgets/image_view.dart';
import 'package:pallon_app/feature/AddRequest/functions/req_function.dart';
import 'package:pallon_app/models/catalog_item_model.dart';
import 'package:pallon_app/models/req_model.dart';
import '../../../models/catalog_model.dart';
import '../../../models/sub_cat_model.dart';
import '../../../models/sub_sub_cat.dart';
import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';


class CompeleteReqWidget extends StatefulWidget{
  ReqModel req;
  List<Catalog> cat;
  CompeleteReqWidget(this.req,this.cat);
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
  List<Catalog> _fullCatalog = [];
  Catalog? _selectedCatalog;
  SubCatModel? _selectedSubCat;
  SubSubCatModel? _selectedSubSubCat;
  CatalogItemModel? _selectedItem;
  List<CatalogItemModel> _selectedItems = [];
  String? _selectbank;
  String? _selectBranch;
  List<String> bank=[
    "نقدي", "اجل", "تحويل بنكي", "الاهلي الروضة", "الاهلي البساتين", "الانماء", "شبكة", "مدي", "فيزا"
  ];
  List<String> brach=[
    "الروضة", "البساتين", "توصيل", "توصيل و تركيب", "شحن خارج جدة"
  ];

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
    _fullCatalog=widget.cat;
  }
  void GetAllCatalog()async{
    List<Catalog> cats=[];
    cats=await GetAllCatalogData();
    setState(() {
      _fullCatalog=cats;
    });
  }

  void GetUserType()async{
    userModel =await GetUserData(_auth.currentUser!.uid);
    setState(() {
      userModel;
    });
  }

  void _addItemToTable() {
    if (_selectedItem != null) {
      setState(() {
        _selectedItems.add(
            CatalogItemModel(
                doc: _selectedItem!.doc,
                name: _selectedItem!.name,
                path:_selectedItem!. path,
                des: _countController.text,
                price: _selectedItem!.price
            )
        );
        _totlaprice+=double.parse(_selectedItem!.price);
      });
      _countController.clear();
      _selectedCatalog = null;
      _selectedSubCat = null;
      _selectedSubSubCat = null;
      _selectedItem = null;
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double formFieldSpacing = screenHeight * 0.02;
    double imagePickerHeight = screenHeight * 0.2;
    double imagePickerBorderWidth = screenWidth * 0.005;
    double imagePickerBorderRadius = screenWidth * 0.025;
    double uploadTextSpacing = screenHeight * 0.01;
    double uploadTextFontSize = screenWidth * 0.04;
    double imagePreviewWidth = screenWidth * 0.4;
    double imagePreviewMargin = screenWidth * 0.02;
    double imagePreviewBorderRadius = screenWidth * 0.02;
    double removeImageButtonPadding = screenWidth * 0.01;
    double removeImageButtonIconSize = screenWidth * 0.04;

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
                      // 1. Catalog Dropdown
                      _buildCatalogDropdown(),
                      SizedBox(height: formFieldSpacing),
                      // 2. SubCat Dropdown (Visible only if Catalog is selected)
                      if (_selectedCatalog != null) ...[
                        _buildSubCatDropdown(),
                        SizedBox(height: formFieldSpacing),
                      ],
                      // 3. SubSubCat Dropdown (Visible only if SubCat is selected AND it has sub-sub categories)
                      if (_selectedSubCat != null && _selectedSubCat!.subsub.isNotEmpty) ...[
                        _buildSubSubCatDropdown(),
                        SizedBox(height: formFieldSpacing),
                      ],
                      // 4. Final Item Dropdown (Visible if a category level that contains items is selected)
                      if (_selectedSubCat != null && (_selectedSubCat!.items.isNotEmpty || (_selectedSubSubCat != null && _selectedSubSubCat!.items.isNotEmpty))) ...[
                        _buildItemDropdown(),
                        SizedBox(height: formFieldSpacing),
                      ],
                      // 5. Show Item Image
                      if(_selectedItem !=null)...[
                        InkWell(
                          onTap: (){
                            Get.to(ViewImage(_selectedItem!.path),transition: Transition.zoom,duration: Duration(seconds: 1));
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: CachedNetworkImageProvider(_selectedItem!.path),
                          ),
                        ),
                        SizedBox(height: formFieldSpacing),
                        Text("Description : ${_selectedItem!.des}"),
                        SizedBox(height: formFieldSpacing),
                        Text("Price : ${_selectedItem!.price}"),
                        SizedBox(height: formFieldSpacing),
                      ],

                    ],
                  ),
                ),
                TextFormField(
                  controller: _countController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
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
                                    decoration: const BoxDecoration(
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
                    : const SizedBox.shrink(),
                const SizedBox(height: 32),
                const Text("Notes"),
                TextFormField(
                  controller: _notes,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 32),
                userModel.type=="client"?const SizedBox.shrink():const Text("Deposit"),
                userModel.type=="client"?const SizedBox.shrink():TextFormField(
                  controller: _deposit,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 32),
                userModel.type=="client"?const SizedBox.shrink():DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Bank",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: _selectbank,
                    items: bank.map((String bankValue){
                      return DropdownMenuItem<String>(
                        value: bankValue,
                        child: Text(bankValue),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectbank = newValue!;
                      });
                    },
                    validator: (value){
                      if (value == null){
                        return 'Please select an item';
                      }
                      return null;
                    }
                ),
                const SizedBox(height: 32),
                DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Receiving",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    value: _selectBranch,
                    items: brach.map((String bankValue){
                      return DropdownMenuItem<String>(
                        value: bankValue,
                        child: Text(bankValue),
                      );
                    }).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        _selectBranch = newValue!;
                      });
                    },
                    validator: (value){
                      if (value == null){
                        return 'Please select an item';
                      }
                      return null;
                    }
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
                              _images, _selectedItems, _notes.text, double.parse(_deposit.text), fees, _totlaprice,
                              _selectBranch.toString(),_selectbank.toString());
                        }
                        else{
                          Submit(userModel, _AddDesgin, widget.req, _selectedItems,
                              _notes.text, double.parse(_deposit.text),
                              fees, _totlaprice,_selectBranch.toString(),_selectbank.toString());
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

  // --- NEW CASCADING DROPDOWN WIDGETS ---

  Widget _buildCatalogDropdown() {
    return DropdownButtonFormField<Catalog>(
      decoration: const InputDecoration(
        labelText: 'Select Catalog',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selectedCatalog,
      items: _fullCatalog.map((Catalog cat) {
        return DropdownMenuItem<Catalog>(
          value: cat,
          child: Text(cat.cat),
        );
      }).toList(),
      onChanged: (Catalog? newValue) {
        setState(() {
          _selectedCatalog = newValue;
          // Reset lower levels when top level changes
          _selectedSubCat = null;
          _selectedSubSubCat = null;
          _selectedItem = null;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a catalog';
        }
        return null;
      },
    );
  }

  Widget _buildSubCatDropdown() {
    List<SubCatModel> subCats = _selectedCatalog?.sub ?? [];
    return DropdownButtonFormField<SubCatModel>(
      decoration: const InputDecoration(
        labelText: 'Select Sub-Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selectedSubCat,
      items: subCats.map((SubCatModel subCat) {
        return DropdownMenuItem<SubCatModel>(
          value: subCat,
          child: Text(subCat.sub),
        );
      }).toList(),
      onChanged: (SubCatModel? newValue) {
        setState(() {
          _selectedSubCat = newValue;
          // Reset lower levels when this level changes
          _selectedSubSubCat = null;
          _selectedItem = null;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a sub-category';
        }
        return null;
      },
    );
  }

  Widget _buildSubSubCatDropdown() {
    List<SubSubCatModel> subSubCats = _selectedSubCat?.subsub ?? [];
    return DropdownButtonFormField<SubSubCatModel>(
      decoration: const InputDecoration(
        labelText: 'Select Sub-Sub-Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selectedSubSubCat,
      items: subSubCats.map((SubSubCatModel subSubCat) {
        return DropdownMenuItem<SubSubCatModel>(
          value: subSubCat,
          child: Text(subSubCat.subsub),
        );
      }).toList(),
      onChanged: (SubSubCatModel? newValue) {
        setState(() {
          _selectedSubSubCat = newValue;
          // Reset final item when this level changes
          _selectedItem = null;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select a sub-sub-category';
        }
        return null;
      },
    );
  }

  Widget _buildItemDropdown() {
    // Items are sourced from EITHER SubSubCat (if selected) OR SubCat
    List<CatalogItemModel> availableItems = [];

    if (_selectedSubSubCat != null) {
      availableItems = _selectedSubSubCat!.items ;
    } else if (_selectedSubCat != null) {
      availableItems = _selectedSubCat!.items;
    }

    return DropdownButtonFormField<CatalogItemModel>(
      decoration: const InputDecoration(
        labelText: 'Select Final Item',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selectedItem,
      items: availableItems.map((CatalogItemModel item) {
        return DropdownMenuItem<CatalogItemModel>(
          value: item,
          child: Text(item.name),
        );
      }).toList(),
      onChanged: (CatalogItemModel? newValue) {
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
    );
  }
  
  Widget _buildItemTable(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    List<DataRow> rows = [];
    for (var item in _selectedItems) {
      rows.add(DataRow(
        cells: [
          DataCell(Text(item.name)),
          DataCell(CircleAvatar(backgroundImage: CachedNetworkImageProvider(item.path),)),
          DataCell(Text(item.price)),
          DataCell(Text(item.des.toString())),
          DataCell(
            IconButton(
              icon: const Icon(Icons.delete_outlined, color: Color(0xFFCE232B)),
              onPressed: () {
                setState(() {
                  _totlaprice-=double.parse(item.price);
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
          _buildDataColumn('Image', screenWidth),
          _buildDataColumn('Price', screenWidth),
          _buildDataColumn('Notes', screenWidth),
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
