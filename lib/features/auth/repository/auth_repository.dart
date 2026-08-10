import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future<UserCredential>signup({ required String email,required String password})async{
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }
  Future<UserCredential>login({ required String email,required String password})async{
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  
}