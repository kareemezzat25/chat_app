import 'package:chat_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBubble extends StatelessWidget {
  bool isLeft;
  String message;
  CustomBubble({required this.isLeft, required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLeft ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isLeft ? AppColors.primaryColor : Colors.blue[700],
          borderRadius: isLeft
              ? BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                )
              : BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
        ),
        child: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
