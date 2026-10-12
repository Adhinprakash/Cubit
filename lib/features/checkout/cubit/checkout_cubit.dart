// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import 'checkout_state.dart';

// class CheckoutCubit extends Cubit<CheckoutState> {
//   final Razorpay razorpay;

//   CheckoutCubit({
//     required double subtotal,
//   })  : razorpay = Razorpay(),
//         super(
//           CheckoutState(
//             subtotal: subtotal,
//             deliveryFee: 5,
//             discount: 20,
//             total: subtotal + 5 - 20,
//           ),
//         ) {
//     _initializeRazorpay();
//   }

//   // --------------------------------------------------
//   // Razorpay listeners
//   // --------------------------------------------------

//   void _initializeRazorpay() {
//     razorpay.on(
//       Razorpay.EVENT_PAYMENT_SUCCESS,
//       _handlePaymentSuccess,
//     );

//     razorpay.on(
//       Razorpay.EVENT_PAYMENT_ERROR,
//       _handlePaymentError,
//     );

//     razorpay.on(
//       Razorpay.EVENT_EXTERNAL_WALLET,
//       _handleExternalWallet,
//     );
//   }

//   // --------------------------------------------------
//   // Payment method
//   // --------------------------------------------------

//   void selectPaymentMethod(String paymentMethod) {
//     emit(
//       state.copyWith(
//         selectedPayment: paymentMethod,
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // Delivery method
//   // --------------------------------------------------

//   void selectDeliveryMethod(String deliveryMethod) {
//     double deliveryFee = 5;

//     if (deliveryMethod == 'Standard Delivery') {
//       deliveryFee = 0;
//     }

//     final total =
//         state.subtotal + deliveryFee - state.discount;

//     emit(
//       state.copyWith(
//         selectedDelivery: deliveryMethod,
//         deliveryFee: deliveryFee,
//         total: total,
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // Open Razorpay
//   // --------------------------------------------------

//   void makePayment() {
//     if (state.total <= 0) {
//       emit(
//         state.copyWith(
//           status: CheckoutStatus.failure,
//           errorMessage: 'Invalid payment amount',
//         ),
//       );

//       return;
//     }

//     emit(
//       state.copyWith(
//         status: CheckoutStatus.loading,
//         errorMessage: '',
//       ),
//     );

//     final options = {
//       'key': 'YOUR_RAZORPAY_TEST_KEY',

//       // Razorpay expects amount in the smallest
//       // currency unit.
//       //
//       // ₹100 = 10000 paise
//       'amount': (state.total * 100).round(),

//       'name': 'Your Ecommerce App',

//       'description': 'Order Payment',

//       'currency': 'INR',

//       'prefill': {
//         'contact': '9999999999',
//         'email': 'test@example.com',
//       },

//       'theme': {
//         'color': '#20B86B',
//       },
//     };

//     try {
//       razorpay.open(options);
//     } catch (e) {
//       emit(
//         state.copyWith(
//           status: CheckoutStatus.failure,
//           errorMessage: e.toString(),
//         ),
//       );
//     }
//   }

//   // --------------------------------------------------
//   // Payment success
//   // --------------------------------------------------

//   void _handlePaymentSuccess(
//     PaymentSuccessResponse response,
//   ) {
//     emit(
//       state.copyWith(
//         status: CheckoutStatus.success,
//         paymentId: response.paymentId ?? '',
//         errorMessage: '',
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // Payment failure
//   // --------------------------------------------------

//   void _handlePaymentError(
//     PaymentFailureResponse response,
//   ) {
//     emit(
//       state.copyWith(
//         status: CheckoutStatus.failure,
//         errorMessage:
//             response.message ?? 'Payment failed',
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // External wallet
//   // --------------------------------------------------

//   void _handleExternalWallet(
//     ExternalWalletResponse response,
//   ) {
//     emit(
//       state.copyWith(
//         status: CheckoutStatus.success,
//         errorMessage:
//             'External wallet: ${response.walletName}',
//       ),
//     );
//   }

//   // --------------------------------------------------
//   // Dispose Razorpay
//   // --------------------------------------------------

//   @override
//   Future<void> close() {
//     razorpay.clear();
//     return super.close();
//   }
// }