import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pallon_app/Core/Widgets/image_view.dart';
import 'package:pallon_app/feature/Requset/Widget/req_data_table_details.dart';
import 'package:pallon_app/feature/Requset/functions/req_functions.dart';
import 'package:pallon_app/models/req_data_model.dart';


class ReqDetailsWidget extends StatefulWidget{
  ReqDataModel req;
  ReqDetailsWidget(this.req);
  @override
  State<StatefulWidget> createState() {
    return _ReqDetailsWidget();
  }

}


class _ReqDetailsWidget extends State<ReqDetailsWidget>{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController name=TextEditingController();
  TextEditingController total_price=TextEditingController();
  TextEditingController fees_price=TextEditingController();
  TextEditingController dep_price=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController type=TextEditingController();
  TextEditingController nameofevent=TextEditingController();
  TextEditingController address=TextEditingController();
  TextEditingController typeofbuilding=TextEditingController();
  TextEditingController float=TextEditingController();
  TextEditingController hour=TextEditingController();
  TextEditingController date=TextEditingController();
  TextEditingController _banktype=TextEditingController();
  TextEditingController _branch=TextEditingController();
  bool _status=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetAllReqData();
  }
  void GetAllReqData()async{
    widget.req=await GetReqDesign(widget.req);
    setState(() {
      widget.req;
      if(widget.req.status=="inreview"){
        _status=false;
      }
      else{
        _status=true;
      }
    });
    widget.req=await GetReqItem(widget.req);
    setState(() {
      widget.req;
       name=TextEditingController(
         text: widget.req.name
       );
       phone=TextEditingController(
         text: widget.req.phone
       );
       type=TextEditingController(
         text: widget.req.typeOfEvent
       );
       nameofevent=TextEditingController(
         text: widget.req.ownerOfevent
       );
       address=TextEditingController(
         text: widget.req.address
       );
       typeofbuilding=TextEditingController(
         text: widget.req.typeOfBuilding
       );
       float=TextEditingController(
         text: widget.req.float
       );
       hour=TextEditingController(
         text: widget.req.hour
       );
       date=TextEditingController(
         text: widget.req.date
       );
      total_price=TextEditingController(text: widget.req.total);
      fees_price=TextEditingController(text: widget.req.fees);
      dep_price=TextEditingController(text: widget.req.deposite);
      _banktype=TextEditingController(text: widget.req.typebank);
      _branch=TextEditingController(text: widget.req.branch);
    });
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
    double imagePreviewWidth = screenWidth * 0.4;
    double imagePreviewMargin = screenWidth * 0.02;
    double imagePreviewBorderRadius = screenWidth * 0.02;
    double imagePickerHeight = screenHeight * 0.2;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.25,
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
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Request Details',
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Padding(
              padding: const EdgeInsets.all(12.0),
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
                    controller: name,
                    obscureText: false,
                    enabled: false,
                    decoration: InputDecoration(
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
                    'Phone Number',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: phone,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Type Of Event',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: type,
                    obscureText: false,
                    decoration: InputDecoration(
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
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Owner Of Event',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: nameofevent,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Hour',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: hour,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Date',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: date,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.datetime,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Address',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: address,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    keyboardType: TextInputType.streetAddress,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'type of building',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: typeofbuilding,
                    obscureText: false,
                    decoration: InputDecoration(
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
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Float',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: float,
                    obscureText: false,
                    decoration: InputDecoration(
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
                  Text("Items",style: TextStyle(
                    fontSize: screenWidth*0.07,
                    fontWeight: FontWeight.bold
                  ),),
                  ReqDataTableDetails(widget.req,context),
                  SizedBox(height: screenHeight * 0.04),
                  widget.req.des.isEmpty?Text("No Special Desgin")
                      :Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Special Desgin",style: TextStyle(
                              fontSize: screenWidth*0.07,
                              fontWeight: FontWeight.bold
                          )),
                          GestureDetector(
                                              child: SizedBox(
                          height: imagePickerHeight,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.req.des.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Get.to(ViewImage(widget.req.des[index]),duration: Duration(seconds: 1),transition: Transition.zoom);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: imagePreviewWidth,
                                      margin: EdgeInsets.all(imagePreviewMargin),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(imagePreviewBorderRadius),
                                        image: DecorationImage(
                                          image: NetworkImage(widget.req.des[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                                              ),
                                            ),
                        ],
                      ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notes",style: TextStyle(
                          fontSize: screenWidth*0.07,
                          fontWeight: FontWeight.bold
                      )),
                      Text(
                        "${widget.req.notes}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth*0.06
                        ),
                      ),

                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text(
                    'Branch',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: _branch,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'BankType',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: _banktype,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Deposit',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: dep_price,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Fees',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: fees_price,
                    obscureText: false,
                    decoration: InputDecoration(
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
                    'Total',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  TextFormField(
                    enabled: false,
                    controller: total_price,
                    obscureText: false,
                    decoration: InputDecoration(
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
                 _status?Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: SizedBox(
                     width: double.infinity,
                     height: screenHeight * 0.07,
                     child: ElevatedButton(
                       onPressed: ()async {
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
                         "Jop Order",
                         style: TextStyle(
                             fontSize: screenWidth * 0.05,
                             fontWeight: FontWeight.bold,
                             color: Colors.white),
                       ),
                     ),
                   ),
                 ): Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: screenHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: ()async {
                              await _firestore.collection('req').doc(widget.req.doc).update({
                                'status':'active',
                              }).whenComplete((){Get.back();});

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
                              "Accept",
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
                            onPressed: ()async {
                              await _firestore.collection('req').doc(widget.req.doc).delete();
                              Get.back();
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
                              "Reject",
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}