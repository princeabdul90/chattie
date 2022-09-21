/*
* Developer: Abubakar Abdullahi
* Date: 11/08/2022
*/
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final DateTime date;
  final String? email;

  DocumentReference? reference;

  Message({
    required this.text,
    required this.date,
    this.email,
    this.reference
});

  // convert json data from firestore to message
  factory Message.fromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String,
      date: DateTime.parse(json['date'] as String),
      email: json['email'] as String?,
  );


  // convert message model to json data to be stored in the database
  Map<String, dynamic> toJson() => <String, dynamic>{
    'date': date.toString(),
    'text': text,
    'email': email,
  };

  // converts firestore snapshot to a message
  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    final message = Message.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}