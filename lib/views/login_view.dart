import 'package:chat_app/core/app_colors.dart';
import 'package:chat_app/cubits/auth_cubit.dart';
import 'package:chat_app/cubits/auth_states.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/signup_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "Login";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
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
          } else if (state is LoginSuccessState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              ChatView.routeName,
              (route) => false,
            );
          } else if (state is LoginFailureSState) {
            Navigator.pop(context); // Remove loading dialog
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
                    state.failureMessage ?? "SomeThing went Wrong",
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
        builder: (context, state) => Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          backgroundColor: AppColors.primaryColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Form(
                key: formKey,
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
                      controller: emailController,
                      prefixIcon: Icons.email_rounded,
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
                      buttonText: "Login",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SignUpView.routeName);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't have an account?",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                              ),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
