/*
* Developer: Abubakar Abdullahi
* Date: 11/08/2022
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../ui/custom.dart';

class UserDao extends ChangeNotifier {
  final auth = FirebaseAuth.instance;

  bool isLoggedIn(){
    return auth.currentUser != null;
  }

  String? userId() {
    return auth.currentUser?.uid;
  }

  String? email(){
    return auth.currentUser?.email;
  }

  // SIGN UP
  void signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      notifyListeners();
    }on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        toast('This password is too weak.');
      }else if (e.code == 'email-already-in-use'){
        toast('The account already exist for that email.');

      }
    }catch(e) {
      toast('something went wrong!');
    }
  }


  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );
      notifyListeners();
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        toast('Wrong password provided for that user.');
      }
    }catch (e) {
      toast('something went wrong!');
    }
  }

  void logout() async {
    await auth.signOut();
    notifyListeners();
  }
}