import 'dart:developer';

import 'package:chat_app/models/message_model.dart';
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

  static CollectionReference<MessageModel> getCollectionMessage() {
    return FirebaseFirestore.instance
        .collection("Messages")
        .withConverter<MessageModel>(
          fromFirestore: (snapshot, options) {
            return MessageModel.fromJson(snapshot.data()!);
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

  static Future<void> addMessage(MessageModel message) {
    var collection = getCollectionMessage();
    var docRef = collection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Future<QuerySnapshot<MessageModel>> getMessages() async {
    var collection = getCollectionMessage();

    return await collection.orderBy("date").get();
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
      credential.user!.sendEmailVerification();
      await addUser(user);
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

  static Future<void> login({
    required String email,
    required String password,
    required Function() onLoading,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      onLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.emailVerified) {
        onSuccess();
      } else {
        onError("Email is not verified, Please check your mail and verify");
      }
    } on FirebaseAuthException catch (e) {
      onError("Email or password is not valid");
    } catch (e) {
      onError(e.toString());
    }
  }
}
