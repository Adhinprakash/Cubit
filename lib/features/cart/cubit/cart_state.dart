import 'package:cubit/features/cart/model/cart_model.dart';
import 'package:equatable/equatable.dart';

enum CartStatus { inital, loaded, loading, error }

class CartState extends Equatable {
  final CartStatus cartStatus;
  final List<CartModel> cartItems;
  final double totalPrice;
  final int totalQuantity;
  final String errrorMessage;

  CartState({
    this.cartStatus = CartStatus.inital,
    this.cartItems = const [],
    this.totalPrice = 0.0,
    this.totalQuantity = 0,
    this.errrorMessage = '',
  });

  CartState copyWith(
{
      CartStatus? cartStatus,
    List<CartModel>? cartItems,
    double? totalPrice,
    int? totalQuantity,
    String? errrorMessage,
}
  ) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      cartItems: cartItems ?? this.cartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      errrorMessage: errrorMessage ?? this.errrorMessage,
    );
  }



  @override
  // TODO: implement props
  List<Object?> get props =>  [cartStatus,cartItems,totalPrice,totalQuantity,errrorMessage];
}
