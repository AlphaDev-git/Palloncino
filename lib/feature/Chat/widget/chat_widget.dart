import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pallon_app/feature/Chat/function/chat_function.dart';
import '../../../models/user_model.dart';
import '../../MainScreen/function/main_function.dart';


class ChatWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChatWidget();
  }

}


class _ChatWidget extends State<ChatWidget>{
  List<ChatMessage> messages=[];
  final ChatUser _chatUser=ChatUser(id: "1",firstName: "Momen");
  final FirebaseAuth _auth=FirebaseAuth.instance;
  UserModel userModel=UserModel(doc: "doc", email: "email", phone: "phone", name: "name", pic: "pic", type: "type");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserType();
  }
  void GetUserType()async{
    userModel =await GetUserData(_auth.currentUser!.uid);
    messages=await getChat();
    setState(() {
      userModel;
      messages;
      _chatUser.id=userModel.doc;
      _chatUser.firstName=userModel.name;
      _chatUser.profileImage=userModel.pic;
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
                            'Chat',
                            style: TextStyle(
                              fontSize: screenWidth * 0.085,
                              color: Colors.black,
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
            SizedBox(
              height: screenHeight * 0.599,
              child: DashChat(
                  currentUser: _chatUser,
                  onSend: _SendMassege,
                  messages: messages,
                messageOptions: MessageOptions(
                  showCurrentUserAvatar: true,
                  showOtherUsersName: true,
                  showOtherUsersAvatar: true,
                  showTime: true,
                ),
                inputOptions: InputOptions(
                  alwaysShowSend: true,
                  autocorrect: true,
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
  void _SendMassege(ChatMessage message){
    //lastMSG(message.text.toString());
    setState(() {
      messages=[message,...messages];
    });
    try{
      SaveChat(message);
    }
    catch(e){
      print(e);
    }
  }

}