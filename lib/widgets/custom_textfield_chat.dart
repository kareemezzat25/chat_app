import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/firebase/firebase_manager.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldChat extends StatelessWidget {
  CustomTextFieldChat({super.key});
  TextEditingController messageContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageContoller,
      decoration: InputDecoration(
        labelText: "Message",
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),

        suffixIcon: GestureDetector(
          onTap: () {
            MessageModel messageModel = MessageModel(
              date: DateTime.now(),
              message: messageContoller.text,
              userId: FirebaseAuth.instance.currentUser!.uid,
            );
            FirebaseManager.addMessage(messageModel);
            messageContoller.clear();
          },
          child: Icon(Icons.send, color: AppColors.primaryColor),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
