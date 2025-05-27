import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends StatelessWidget {
  static const String routeName = "Signup";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/scholar.png"),
                SizedBox(height: 12),
                Text(
                  "Scholar Chat",
                  style: GoogleFonts.pacifico(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "SignUp",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  labelText: "UserName",
                  controller: userNameController,
                  prefixIcon: Icons.person,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  labelText: "Email",
                  controller: emailController,
                  prefixIcon: Icons.email_rounded,
                ),
                SizedBox(height: 16),
                CustomTextField(
                  labelText: "Password",
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                ),
                SizedBox(height: 12),
                CustomButton(buttonText: "SignUp", onTap: () {}),
                SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have account?",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: " Login",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
