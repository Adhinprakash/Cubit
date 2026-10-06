import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cubit/features/cart/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepository {
  Future<void>addTocart(CartModel cartModel)async{
    final userId= FirebaseAuth.instance.currentUser!.uid;
    final cartDocId = cartModel.id;


  print(userId);
      final CollectionReference ref = FirebaseFirestore.instance.collection('Users');

  await ref.doc(userId).collection('cart').doc(cartDocId).set(cartModel.toMap());
  }

Future<void>removeCartItem(CartModel cartModel)async{
    final cartDocId = cartModel.id;

  final userId=FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference ref = FirebaseFirestore.instance.collection('Users');
await ref.doc(userId).collection('cart').doc(cartDocId).delete();


}

  Future<List<CartModel>>fetchCartItems()async{

    final userId=FirebaseAuth.instance.currentUser?.uid;
    print(userId);
    final CollectionReference ref = FirebaseFirestore.instance.collection('Users');
final QuerySnapshot snapshot=await ref.doc(userId).collection('cart').get();

return snapshot.docs.map((docs)=>CartModel.fromMap(docs.data()as Map<String,dynamic>)).toList();
    

  }

  Future<void>updateQuantity(CartModel cartmodel)async{
        final cartDocId = cartmodel.id;

    final userId=FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference ref = FirebaseFirestore.instance.collection('Users').doc(userId).collection('cart');


await ref.doc(cartDocId).update({
  'quantity':cartmodel.quantity,
}); 
  }
}