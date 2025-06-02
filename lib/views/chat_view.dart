import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/widgets/custom_bubble.dart';
import 'package:chat_app/widgets/custom_textfield_chat.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
                itemBuilder: (context, index) {
                  return CustomBubble(isLeft: index.isEven);
                },
                itemCount: 10,
              ),
            ),
            CustomTextFieldChat(),
          ],
        ),
      ),
    );
  }
}
