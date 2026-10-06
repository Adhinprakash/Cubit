import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavRepository {


Future<Set<String>>fetchFavIds()async{
final userId= FirebaseAuth.instance.currentUser?.uid;

  print(userId);
    final  QuerySnapshot  snapshot=await FirebaseFirestore.instance.collection('Users').doc(userId).collection('favorites').get();

    final documentIds=snapshot.docs.map((doc)=>doc.id).toSet();

    return documentIds;
 
  
}

Future<void>addFavorite(String productIds)async{
  final userId= FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference ref=  FirebaseFirestore.instance.collection('Users');
 await ref.doc(userId).collection('favorites').doc(productIds).set({
   'createdAt': FieldValue.serverTimestamp()
  });
}

Future<void>removeFavorite(String productIds)async{
    final userId= FirebaseAuth.instance.currentUser?.uid;

   final CollectionReference ref=  FirebaseFirestore.instance.collection('Users');
 await ref.doc(userId).collection('favorites').doc(productIds).delete();
}
}


