/*
* Developer: Abubakar Abdullahi
* Date: 11/08/2022
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'message.dart';

class MessageDao {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('messages');

    // saveMessage
  void saveMessage(Message message) {
    collection.add(message.toJson());
  }

   // getMessageStream
  Stream<QuerySnapshot> getMessageStream() {
    return collection.orderBy('date').snapshots();
  }

}
