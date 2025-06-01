import 'package:chat_app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  String labelText;
  TextEditingController controller;
  IconData prefixIcon;
  CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$labelText is required";
        } else if (labelText == "Email") {
          final emailRegex = RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
          );

          if (!emailRegex.hasMatch(value)) {
            return "Please enter a valid email address";
          }
        } else if (labelText == "Age") {
          final age = int.tryParse(value ?? '');
          if (age == null) {
            return "Please enter a valid number for age";
          }

          if (age < 12 || age > 65) {
            return "Please enter a valid age from 12 to 65";
          }
        } else if (labelText == "Password") {
          if (labelText.length < 6) {
            return "Please Enter strong password";
          }
        }
        return null;
      },
      cursorColor: AppColors.secondayColor,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.secondayColor,
      ),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.secondayColor,
        ),

        prefixIcon: Icon(prefixIcon, color: AppColors.secondayColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondayColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondayColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondayColor),
        ),
      ),
    );
  }
}
