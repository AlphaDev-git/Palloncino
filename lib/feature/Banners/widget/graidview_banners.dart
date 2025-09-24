import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


final FirebaseFirestore _firestore=FirebaseFirestore.instance;


Widget GradViewBanners(BuildContext context){
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('banner').snapshots(),
    builder: (context,snapshot){
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFF07933E),
          ),
        );
      }
      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return const Center(
          child: Text('No items found.'),
        );
      }
      final messages = snapshot.data!.docs;
      for (var message in messages.reversed){}
      return Text("");
    },
  );
}