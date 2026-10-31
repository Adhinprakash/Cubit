import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAthDataSource {
  final FirebaseAuth firebaseAuth;

  FirebaseAthDataSource(this.firebaseAuth);



  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signup({
    required String email,
    required String password,
  }) {
    return firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
Future<UserCredential> googleLogin() async {
    if (kIsWeb) {
      return firebaseAuth.signInWithPopup(
        GoogleAuthProvider(),
      );
    }

    final googleSignIn = GoogleSignIn.instance;
    final account = await googleSignIn.authenticate();
    final googleAuth = account.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return firebaseAuth.signInWithCredential(credential);
  }


    Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) {
    return firebaseAuth.sendPasswordResetEmail(
      email: email,
    );
  }
}