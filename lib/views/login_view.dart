import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "Login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/scholar.png"),
            SizedBox(height: 12),
            Text(
              "Scholar Chat",
              style: GoogleFonts.pacifico(
                fontSize: 24,
                color: AppColors.secondayColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Login",
              style: GoogleFonts.inter(
                fontSize: 20,
                color: AppColors.secondayColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12),
            CustomTextField(
              labelText: "Email",
              hintText: "Enter Your Email",
              controller: emailController,
              prefixIcon: Icons.email_rounded,
            ),
            SizedBox(height: 12),
            CustomTextField(
              labelText: "Password",
              hintText: "Enter Your Password",
              controller: passwordController,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 12),
            CustomButton(buttonText: "Login", onTap: () {}),
            SizedBox(height: 8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have an account?",
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                  ),
                  TextSpan(
                    text: " SignUp",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
