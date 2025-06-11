import 'dart:developer' show log;

import 'package:chat_app/cubits/auth_states.dart';
import 'package:chat_app/firebase/firebase_manager.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  login(String email, String password) async {
    try {
      emit(LoginLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.emailVerified) {
        emit(LoginSuccessState());
      } else {
        emit(
          LoginFailureSState(
            failureMessage:
                "Email is not verified, Please check your mail and verify",
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(
        LoginFailureSState(failureMessage: "Email or password is not valid"),
      );
    } catch (e) {
      emit(LoginFailureSState(failureMessage: e.toString()));
    }
  }

  signUp(String email, String userName, String password, String age) async {
    try {
      emit(SignUpLoadingState());
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: credential.user!.uid,
        username: userName,
        email: email,
        age: age,
      );
      credential.user!.sendEmailVerification();
      await FirebaseManager.addUser(user);
      emit(SignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        emit(
          SignUpFailureState(
            failureMessage: 'The password provided is too weak.',
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        emit(
          SignUpFailureState(
            failureMessage: 'The account already exists for that email.',
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      emit(SignUpFailureState(failureMessage: "SomeThing Went Wrong"));
    }
  }
}
