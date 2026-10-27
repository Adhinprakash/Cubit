import 'package:cubit/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
class FirebaseAuthRepository implements AuthRepository {


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;





  // Future<UserCredential>signup({ required String email,required String password})async{
  //   return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    
  // }
  // Future<UserCredential>login({ required String email,required String password})async{
  //   return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  // }
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
  
}

Future<void>resetPassword(String email)async{
  
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> login({
     required String email,required String password}) async{
    // TODO: implement login
      return await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

  }

  @override
  Future<UserCredential> signup({required String email,required String password}) async{
    // TODO: implement signup
    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> googleLogin() async{

final GoogleSignIn googlesignin= await GoogleSignIn.instance;

final GoogleSignInAccount account=await googlesignin.authenticate();
      final GoogleSignInAuthentication googleAuth = account.authentication;

 final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

return firebaseAuth.signInWithCredential(credential);
    // TODO: implement googleLogin
    
  }

}