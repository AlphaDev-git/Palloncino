import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/AddStaff/function/add_staff_function.dart';
import 'package:pallon_app/feature/AddStaff/widget/custom_staff_table.dart';
import 'package:pallon_app/models/user_model.dart';


class AddStaffWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddStaffWidget();
  }
}


class _AddStaffWidget extends State<AddStaffWidget> {
  List<UserModel> staff = [];
  List<UserModel> clients = [];
  UserModel? _selectedClient;
  String? type; // Changed to nullable String
  List<String> types = [
    "Admin",
    'coordinator',
    "driver",
    "vendor"
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getStaffAndClientData();
  }

  void _getStaffAndClientData() async {
    List<UserModel> fetchedStaff = await GetAllStaff();
    List<UserModel> fetchedClients = await GetAllClients();
    print('Fetched clients length: ${fetchedClients.length}');
    setState(() {
      staff = fetchedStaff;
      clients = fetchedClients;
    });
  }

  void _addStaffToTable() {
    if (_formKey.currentState!.validate()) {
      if (_selectedClient != null && type != null) {
        FirebaseFirestore firestore=FirebaseFirestore.instance;
        firestore.collection("user").doc(_selectedClient!.doc).update({
          'type':type!
        });
        setState(() {
          _selectedClient = null; // Clear dropdown selection
          type = null; // Clear dropdown selection
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
                      'Staff',
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<UserModel>(
                      decoration: const InputDecoration(
                        labelText: 'Select User',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: _selectedClient,
                      items: clients.map((UserModel item) {
                        return DropdownMenuItem<UserModel>(
                          value: item,
                          child: Text("Name:${item.name}\nEmail:${item.email}"),
                        );
                      }).toList(),
                      onChanged: (UserModel? newValue) {
                        setState(() {
                          _selectedClient = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select an User';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      value: type,
                      items: types.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          type = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _addStaffToTable,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF07933E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Add Staff',
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
            ),
            SizedBox(
              // Using an explicit height for the table,
              // or better, use Expanded in a Column with SingleChildScrollView.
              // For now, let's keep it simple.
              height: screenHeight * 0.9,
              child: CustomeStaffTable(context),
            )
          ],
        ),
      ),
    );
  }
}