import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthRepository {


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;


  Future<UserCredential>signup({ required String email,required String password})async{
    return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    
  }
  Future<UserCredential>login({ required String email,required String password})async{
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }
Future<void>addTofirebase(String uid,String email)async{
try {
  await FirebaseFirestore.instance
    .collection('Users')
    .doc(uid)
    .set({
  'email': email,
  'createdAt': FieldValue.serverTimestamp(),
});

} catch (e) {
 print(e.toString()); 
}
  
}}