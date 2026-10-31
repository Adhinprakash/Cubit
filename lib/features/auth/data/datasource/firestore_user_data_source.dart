import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreUserDataSource {
  final FirebaseFirestore firestore;

  FirestoreUserDataSource(this.firestore);

  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String username,
  }) async {
    await firestore
        .collection('Users')
        .doc(uid)
        .set({
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}