import 'package:cubit/features/cart/cubit/cart_state.dart';
import 'package:cubit/features/cart/model/cart_model.dart';
import 'package:cubit/features/cart/repository/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository repository;
  CartCubit({required this.repository}) : super(CartState());

  Future<void> fetchAllCartitems() async {
    final cartItemsList = await repository.fetchCartItems();
    emit(state.copyWith(cartItems: cartItemsList));
  }

  Future<void> addToCart(CartModel cartModel) async {
    final oldList = [...state.cartItems];

    final cartList = [...state.cartItems];
    try {
      emit(state.copyWith(cartStatus: CartStatus.loading));
      cartList.add(cartModel);
      final totalPrice = calculateTotalPrice(cartList);
final totalQuantity = calculateTotalQuantity(cartList);
      emit(state.copyWith(cartItems: cartList,totalPrice: totalPrice,totalQuantity: totalQuantity));
      await repository.addTocart(cartModel);
    } catch (e) {
      print(e.toString());
      state.copyWith(cartStatus: CartStatus.error, cartItems: oldList);
    }
  }

  Future<void> removeCartItem(String cartId) async {
    final oldlist = [...state.cartItems];
    final updatelist = [...state.cartItems];
    final cartItem = updatelist.firstWhere((element) => element.id == cartId);
    try {
      updatelist.removeWhere((e) => e.id == cartId);
      await repository.removeCartItem(cartItem);
      final totalPrice = calculateTotalPrice(updatelist);
final totalQuantity = calculateTotalQuantity(updatelist);
      emit(state.copyWith(cartItems: updatelist,totalPrice: totalPrice,totalQuantity: totalQuantity));
    } catch (e) {
      emit(state.copyWith(cartItems: oldlist, cartStatus: CartStatus.error));
    }
  }

  Future<void> increaseQuantity(CartModel cartmodel) async {
    final oldList = [...state.cartItems];

    try {
      final updatedList = state.cartItems.map((item) {
        if (item.id == cartmodel.id) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
final totalPrice = calculateTotalPrice(updatedList);
final totalQuantity = calculateTotalQuantity(updatedList);
      emit(state.copyWith(cartItems: updatedList,totalPrice: totalPrice,totalQuantity: totalQuantity));
      print(updatedList.map((e) => print(e.quantity)));
      await repository.updateQuantity(
        updatedList.firstWhere((item) => item.id == cartmodel.id),
      );
    } catch (e) {
      emit(
        state.copyWith(
          cartItems: oldList,
          errrorMessage: e.toString(),
          cartStatus: CartStatus.error,
        ),
      );
    }
  }

  Future<void> decreaseQuantity(CartModel cartmodel) async {
    final oldList = [...state.cartItems];

    final currentItem = state.cartItems.firstWhere(
      (item) => item.id == cartmodel.id,
    );

    try {
      if (currentItem.quantity == 1) {
        final updatedList = state.cartItems
            .where((item) => !(item.id == cartmodel.id))
            .toList();
final totalPrice = calculateTotalPrice(updatedList);
final totalQuantity = calculateTotalQuantity(updatedList);
        emit(state.copyWith(cartItems: updatedList,totalPrice: totalPrice,totalQuantity: totalQuantity));

        await repository.removeCartItem(currentItem);

        return;
      }

      final updatedList = state.cartItems.map((item) {
        if (item.id == cartmodel.id) {
          return item.copyWith(quantity: item.quantity - 1);
        }
        return item;
      }).toList();
      final totalPrice = calculateTotalPrice(updatedList);
final totalQuantity = calculateTotalQuantity(updatedList);
      emit(state.copyWith(cartItems: updatedList,totalPrice: totalPrice,totalQuantity: totalQuantity));
      await repository.updateQuantity(
        updatedList.firstWhere((item) => item.id == cartmodel.id),
      );
    } catch (e) {
      emit(
        state.copyWith(
          cartItems: oldList,
          errrorMessage: e.toString(),
          cartStatus: CartStatus.error,
        ),
      );
    }
  }



  bool isIncart(String productId, String color, String size) {
    final uniqueProductId = '${productId}_${color}_${size}';

    print('Checking product: $productId');
    print('Checking color: $color');
    print('Checking size: $size');

    print('Cart items: ${state.cartItems.length}');

    for (final item in state.cartItems) {
      print(
        'Cart item -> '
        'id: ${item.id}, '
        'color: ${item.selectedColor},'
        'size: ${item.selectedSize}',
      );
    }

    return state.cartItems.any((item) => item.id == uniqueProductId);
  }


  bool isCartEmpty(){
    return state.cartItems.isEmpty;
  }

double getTotalprice(){
  print(state.totalQuantity);
  return state.totalPrice;
}

  double calculateTotalPrice(List<CartModel> items) {
  return items.fold(
    0,
    (total, item) => total + (item.price * item.quantity),
  );
}
int calculateTotalQuantity(List<CartModel> items) {
  return items.fold(
    0,
    (total, item) => total + item.quantity,
  );
}

}
