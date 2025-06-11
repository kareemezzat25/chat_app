import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/cubits/auth_cubit.dart';
import 'package:chat_app/cubits/auth_states.dart';
import 'package:chat_app/firebase/firebase_manager.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends StatelessWidget {
  static const String routeName = "Signup";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.transparent,
                  title: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              },
            );
            Future.delayed(Duration(seconds: 2));
          } else if (state is SignUpSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ChatView.routeName,
              (route) => false,
            );
          } else if (state is SignUpFailureState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: AppColors.secondayColor,
                  title: Text(
                    "Error",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  content: Text(
                    state.failureMessage ?? "",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[850],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                      child: Text("Ok"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Center(
                child: Form(
                  key: formKey,
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
                        labelText: "Age",
                        controller: ageController,
                        prefixIcon: Icons.cake,
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        labelText: "Password",
                        controller: passwordController,
                        isobscure: true,
                        prefixIcon: Icons.lock,
                      ),
                      SizedBox(height: 12),
                      CustomButton(
                        buttonText: "SignUp",
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).signUp(
                              emailController.text,
                              userNameController.text,
                              passwordController.text,
                              ageController.text,
                            );
                          }
                        },
                      ),
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
          ),
        ),
      ),
    );
  }
}
