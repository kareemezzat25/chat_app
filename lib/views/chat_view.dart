import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/firebase/firebase_manager.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/custom_bubble.dart';
import 'package:chat_app/widgets/custom_textfield_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatView extends StatelessWidget {
  static const String routeName = "ChatView";
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/scholar.png",
              height: 60,
              fit: BoxFit.fill,
            ),
            Text(
              "Chat",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<QuerySnapshot<MessageModel>>(
        future: FirebaseManager.getMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "SomeThing went Wrong when i get data",
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                    itemBuilder: (context, index) {
                      return CustomBubble(
                        message:
                            snapshot.data?.docs[index].data().message ?? "",
                        isUser:
                            snapshot.data?.docs[index].data().userId !=
                            FirebaseAuth.instance.currentUser!.uid,
                      );
                    },
                    itemCount: snapshot.data?.docs.length ?? 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CustomTextFieldChat(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
