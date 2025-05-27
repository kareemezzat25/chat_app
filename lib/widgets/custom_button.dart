import 'package:chat_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  Function() onTap;
  CustomButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: AppColors.secondayColor,
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.inter(
          fontSize: 20,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
