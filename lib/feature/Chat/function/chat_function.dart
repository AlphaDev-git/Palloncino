import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';


FirebaseFirestore _firestore=FirebaseFirestore.instance;
void SaveChat(ChatMessage message)async{

  String docM=DateTime.now().toString();
  await _firestore.collection('chat').doc(docM).set({
    'text':message.text,
    'date':message.createdAt.toString(),
    'user':message.user.firstName,
    'userdoc':message.user.id,
    'doc':docM,
    'pic':message.user.profileImage,
  });
}

Future<List<ChatMessage>> getChat()async{
  List<ChatMessage> chats=[];
  await _firestore.collection('chat').get().then((value){
    for(int i=0;i<value.size;i++){
      ChatUser user=ChatUser(id: value.docs[i].get('userdoc'),firstName:value.docs[i].get('user') ,
          profileImage:value.docs[i].get('pic') );
      chats.add(ChatMessage(
          text:value.docs[i].get('text') ,
          user: user,
          createdAt: DateTime.parse(value.docs[i].get('date')))
      );
    }
  }).whenComplete((){
    return chats;
  });
  return chats;
}