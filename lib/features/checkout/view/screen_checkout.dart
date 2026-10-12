// import 'package:cubit/features/checkout/cubit/checkout_cubit.dart';
// import 'package:cubit/features/checkout/cubit/checkout_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';



// class ScreenCheckout extends StatelessWidget {
//   const ScreenCheckout({
//     super.key,
//     required this.subtotal,
//   });

//   final double subtotal;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => CheckoutCubit(
//         subtotal: subtotal,
//       ),
//       child: const _CheckoutView(),
//     );
//   }
// }

// class _CheckoutView extends StatelessWidget {
//   const _CheckoutView();

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CheckoutCubit, CheckoutState>(
//       listener: (context, state) {
//         if (state.status == CheckoutStatus.success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 state.paymentId.isEmpty
//                     ? 'Payment successful'
//                     : 'Payment successful\n'
//                       'Payment ID: ${state.paymentId}',
//               ),
//             ),
//           );
//         }

//         if (state.status == CheckoutStatus.failure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errorMessage),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF8F9FA),

//           appBar: AppBar(
//             backgroundColor: const Color(0xFFF8F9FA),
//             elevation: 0,
//             centerTitle: true,

//             leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 size: 20,
//                 color: Color(0xFF202124),
//               ),
//             ),

//             title: const Text(
//               'Checkout',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF202124),
//               ),
//             ),

//             actions: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.more_horiz,
//                   size: 24,
//                   color: Color(0xFF202124),
//                 ),
//               ),

//               const SizedBox(width: 8),
//             ],
//           ),

//           body: SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [

//                   // -----------------------------------
//                   // DELIVERY LOCATION
//                   // -----------------------------------

//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Delivery location',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       Text(
//                         'Change',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   Container(
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius:
//                           BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceAround,
//                       children: const [
//                         Icon(
//                           Icons.location_pin,
//                           color: Colors.blue,
//                           size: 40,
//                         ),

//                         Expanded(
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                               right: 10,
//                             ),
//                             child: Text(
//                               'putoorkavil, eramanagalam po '
//                               'balussery via kodls',
//                               maxLines: 2,
//                               overflow:
//                                   TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // -----------------------------------
//                   // DELIVERY METHOD
//                   // -----------------------------------

//                   const Text(
//                     'Method of delivery',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       deliveryTypeWidget(
//                         context,
//                         'Express Delivery',
//                         state.selectedDelivery ==
//                             'Express Delivery',
//                       ),

//                       deliveryTypeWidget(
//                         context,
//                         'Standard Delivery',
//                         state.selectedDelivery ==
//                             'Standard Delivery',
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   // -----------------------------------
//                   // PAYMENT METHOD
//                   // -----------------------------------

//                   const Text(
//                     'Payment method',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF171717),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   paymentMethodWidget(
//                     context,
//                     isSelected:
//                         state.selectedPayment == 'card',
//                     paymentMethod: 'card',
//                     imageUrl:
//                         'assets/images/mastercard-26161.png',
//                   ),

//                   const SizedBox(height: 10),

//                   paymentMethodWidget(
//                     context,
//                     isSelected:
//                         state.selectedPayment == 'apple',
//                     paymentMethod: 'apple',
//                     imageUrl:
//                         'assets/images/png-apple-logo-9713.png',
//                   ),

//                   const SizedBox(height: 10),

//                   paymentMethodWidget(
//                     context,
//                     isSelected:
//                         state.selectedPayment == 'gpay',
//                     paymentMethod: 'gpay',
//                     imageUrl:
//                         'assets/images/google-plus-png-logo-3704.png',
//                   ),

//                   const SizedBox(height: 20),

//                   // -----------------------------------
//                   // ORDER SUMMARY
//                   // -----------------------------------

//                   const Text(
//                     'Order Summary',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF202124),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   PriceRow(
//                     title: 'Subtotal',
//                     price:
//                         '₹${state.subtotal.toStringAsFixed(2)}',
//                   ),

//                   const SizedBox(height: 12),

//                   PriceRow(
//                     title: 'Delivery Fee',
//                     price:
//                         '₹${state.deliveryFee.toStringAsFixed(2)}',
//                   ),

//                   const SizedBox(height: 12),

//                   PriceRow(
//                     title: 'Discount',
//                     price:
//                         '-₹${state.discount.toStringAsFixed(2)}',
//                     priceColor:
//                         const Color(0xFF20B86B),
//                   ),

//                   const SizedBox(height: 16),

//                   const Divider(
//                     color: Color(0xFFE4E6E9),
//                     height: 1,
//                   ),

//                   const SizedBox(height: 16),

//                   PriceRow(
//                     title: 'Total',
//                     price:
//                         '₹${state.total.toStringAsFixed(2)}',
//                     titleWeight: FontWeight.w700,
//                     priceWeight: FontWeight.w700,
//                     titleFontSize: 17,
//                     priceFontSize: 19,
//                   ),

//                   const SizedBox(height: 100),
//                 ],
//               ),
//             ),
//           ),

//           // -------------------------------------------
//           // CHECKOUT BUTTON
//           // -------------------------------------------

//           bottomNavigationBar: Container(
//             padding: const EdgeInsets.fromLTRB(
//               16,
//               12,
//               16,
//               16,
//             ),
//             decoration: const BoxDecoration(
//               color: Color(0xFFF8F9FA),
//             ),
//             child: SizedBox(
//               height: 56,
//               child: ElevatedButton(
//                 onPressed:
//                     state.status == CheckoutStatus.loading
//                         ? null
//                         : () {
//                             context
//                                 .read<CheckoutCubit>()
//                                 .makePayment();
//                           },

//                 style: ElevatedButton.styleFrom(
//                   backgroundColor:
//                       const Color(0xFF20B86B),
//                   foregroundColor: Colors.white,
//                   disabledBackgroundColor:
//                       Colors.grey,
//                   elevation: 0,
//                   shape:
//                       RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.circular(16),
//                   ),
//                 ),

//                 child:
//                     state.status ==
//                             CheckoutStatus.loading
//                         ? const SizedBox(
//                             height: 24,
//                             width: 24,
//                             child:
//                                 CircularProgressIndicator(
//                               color: Colors.white,
//                               strokeWidth: 2.5,
//                             ),
//                           )
//                         : Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.center,
//                             children: [
//                               const Text(
//                                 'Checkout',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight:
//                                       FontWeight.w600,
//                                 ),
//                               ),

//                               const SizedBox(width: 8),

//                               const Text(
//                                 '•',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight:
//                                       FontWeight.bold,
//                                 ),
//                               ),

//                               const SizedBox(width: 8),

//                               Text(
//                                 '₹${state.total.toStringAsFixed(2)}',
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight:
//                                       FontWeight.w700,
//                                 ),
//                               ),

//                               const SizedBox(width: 6),

//                               const Icon(
//                                 Icons.arrow_forward,
//                                 size: 19,
//                               ),
//                             ],
//                           ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // ==================================================
//   // DELIVERY WIDGET
//   // ==================================================

//   Widget deliveryTypeWidget(
//     BuildContext context,
//     String content,
//     bool isSelected,
//   ) {
//     return GestureDetector(
//       onTap: () {
//         context
//             .read<CheckoutCubit>()
//             .selectDeliveryMethod(content);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 10,
//           vertical: 5,
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected
//                 ? Colors.blue
//                 : Colors.grey,
//           ),
//           borderRadius:
//               BorderRadius.circular(12),
//         ),
//         child: Text(
//           content,
//           style: TextStyle(
//             fontSize: 15,
//             color: isSelected
//                 ? Colors.blue
//                 : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }

//   // ==================================================
//   // PAYMENT WIDGET
//   // ==================================================

//   Widget paymentMethodWidget(
//     BuildContext context, {
//     required bool isSelected,
//     required String paymentMethod,
//     required String imageUrl,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         context
//             .read<CheckoutCubit>()
//             .selectPaymentMethod(paymentMethod);
//       },
//       child: AnimatedContainer(
//         duration:
//             const Duration(milliseconds: 180),
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(
//           horizontal: 14,
//           vertical: 12,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius:
//               BorderRadius.circular(14),
//           border: Border.all(
//             color: isSelected
//                 ? const Color(0xFF2878E8)
//                 : const Color(0xFFD7D7D7),
//             width: isSelected ? 1.5 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             AnimatedContainer(
//               duration:
//                   const Duration(milliseconds: 150),
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected
//                       ? const Color(0xFF2878E8)
//                       : const Color(0xFFD0D0D0),
//                   width:
//                       isSelected ? 2.5 : 1.5,
//                 ),
//               ),
//               child: isSelected
//                   ? Center(
//                       child: Container(
//                         width: 10,
//                         height: 10,
//                         decoration:
//                             const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color:
//                               Color(0xFF2878E8),
//                         ),
//                       ),
//                     )
//                   : null,
//             ),

//             const SizedBox(width: 14),

//             Image.asset(
//               imageUrl,
//               height: 25,
//               width: 25,
//               fit: BoxFit.contain,
//               errorBuilder:
//                   (context, error, stackTrace) {
//                 return const Icon(
//                   Icons.image_outlined,
//                   color: Color(0xFFB0B2B7),
//                   size: 30,
//                 );
//               },
//             ),

//             const SizedBox(width: 8),

//             const Text(
//               'Pay',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF555555),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ====================================================
// // PRICE ROW
// // ====================================================

// class PriceRow extends StatelessWidget {
//   final String title;
//   final String price;
//   final Color? priceColor;

//   final FontWeight titleWeight;
//   final FontWeight priceWeight;

//   final double titleFontSize;
//   final double priceFontSize;

//   const PriceRow({
//     super.key,
//     required this.title,
//     required this.price,
//     this.priceColor,
//     this.titleWeight = FontWeight.w400,
//     this.priceWeight = FontWeight.w500,
//     this.titleFontSize = 14,
//     this.priceFontSize = 14,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment:
//           MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: titleFontSize,
//             fontWeight: titleWeight,
//             color: const Color(0xFF777A82),
//           ),
//         ),
//         Text(
//           price,
//           style: TextStyle(
//             fontSize: priceFontSize,
//             fontWeight: priceWeight,
//             color: priceColor ??
//                 const Color(0xFF202124),
//           ),
//         ),
//       ],
//     );
//   }
// }