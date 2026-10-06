
import 'package:cubit/features/cart/cubit/cart_cubit.dart';
import 'package:cubit/features/cart/cubit/cart_state.dart';
import 'package:cubit/features/cart/model/cart_model.dart';
import 'package:cubit/features/checkout/view/screen_checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ScreenCart extends StatelessWidget {
  const ScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
                        Navigator.pop(context);

          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Color(0xFF202124),
          ),
        ),
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF202124),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              size: 24,
              color: Color(0xFF202124),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body:
    BlocBuilder<CartCubit,CartState>(builder: (context, state) {

if(state.cartItems.isEmpty){
 return EmptyCartScreen();
}
      return   Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
        Expanded(child: ListView.builder(
          itemCount: state.cartItems.length,
          itemBuilder: (context, index) {
            final cartItem=state.cartItems[index];

          return CartItemCard(
            cartModel: cartItem,
            );
        
        },)),
        
            const Text(
              'Promo Code',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF202124),
              ),
            ),
        
            const SizedBox(height: 10),
        
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE4E6E9)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_offer_outlined,
                    size: 20,
                    color: Color(0xFF8A8D95),
                  ),
        
                  const SizedBox(width: 10),
        
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter promo code',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9B9DA4),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
        
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 40),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF20B86B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        
          
          ],
        ),
      );
    },),

      bottomNavigationBar: !context.watch<CartCubit>().isCartEmpty()? Builder(
        builder: (context) {
          final totalprice=context.read<CartCubit>().getTotalprice().roundToDouble();
          String displayPrice = totalprice.toStringAsFixed(2);
          return Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenCheckout()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF20B86B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '•',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '\$${displayPrice}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 19),
                  ],
                ),
              ),
            ),
          );
        }
      ):SizedBox()
    );
  }
}



class CartItemCard extends StatelessWidget {
final CartModel cartModel;

  const CartItemCard({
    super.key,
    required, required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    final itemTotalPrice=cartModel.price*cartModel.quantity;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE9EAED)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 92,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                cartModel.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_outlined,
                    color: Color(0xFFB0B2B7),
                    size: 30,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                            cartModel.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.3,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF202124),
                          ),
                        ),
                      ),

                      const SizedBox(width: 6),

                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.close,
                          size: 19,
                          color: Color(0xFF9B9DA4),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    cartModel.selectedColor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A8D95),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${itemTotalPrice}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202124),
                        ),
                      ),

                      QuantitySelector(
                        quantity: cartModel.quantity,
                        onMinus: () {context.read<CartCubit>().decreaseQuantity(cartModel);},
                        onPlus: () {context.read<CartCubit>().increaseQuantity(cartModel);},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          _QuantityButton(icon: Icons.remove, onTap: onMinus),

          SizedBox(
            width: 28,
            child: Center(
              child: Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),
            ),
          ),

          _QuantityButton(icon: Icons.add, onTap: onPlus),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 32,
        height: 34,
        child: Icon(icon, size: 16, color: const Color(0xFF50535A)),
      ),
    );
  }
}

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key, this.onShopNow});

  final VoidCallback? onShopNow;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lotties/empty_cart.json', width: 180, height: 180),
          const SizedBox(height: 8),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Add something you love!',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onShopNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF20B86B),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Shop Now'),
          ),
        ],
      ),
    );
  }
}