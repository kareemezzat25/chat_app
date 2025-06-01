import 'dart:developer';

import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseManager {
  static CollectionReference<UserModel> getCollectioUser() {
    return FirebaseFirestore.instance
        .collection("users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) {
            return UserModel.fromJson(snapshot.data()!);
          },
          toFirestore: (value, options) {
            return value.toJson();
          },
        );
  }

  static Future<void> addUser(UserModel user) {
    var collection = getCollectioUser();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  static Future<void> signup({
    required String email,
    required String password,
    required String username,
    required String age,
    required Function() onLoading,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      onLoading();
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        id: credential.user!.uid,
        username: username,
        email: email,
        age: age,
      );
      addUser(user);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
        onError('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
      onError("SomeThing Went Wrong");
    }
  }
}
