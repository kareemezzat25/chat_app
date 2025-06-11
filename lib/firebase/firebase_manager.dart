import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
