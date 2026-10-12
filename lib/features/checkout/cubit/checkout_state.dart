// import 'package:equatable/equatable.dart';

// enum CheckoutStatus {
//   initial,
//   loading,
//   success,
//   failure,
// }

// class CheckoutState extends Equatable {
//   final CheckoutStatus status;

//   final String selectedPayment;
//   final String selectedDelivery;

//   final double subtotal;
//   final double deliveryFee;
//   final double discount;
//   final double total;

//   final String paymentId;
//   final String errorMessage;

//   const CheckoutState({
//     this.status = CheckoutStatus.initial,
//     this.selectedPayment = 'card',
//     this.selectedDelivery = 'Express Delivery',
//     this.subtotal = 0,
//     this.deliveryFee = 5,
//     this.discount = 20,
//     this.total = 0,
//     this.paymentId = '',
//     this.errorMessage = '',
//   });

//   CheckoutState copyWith({
//     CheckoutStatus? status,
//     String? selectedPayment,
//     String? selectedDelivery,
//     double? subtotal,
//     double? deliveryFee,
//     double? discount,
//     double? total,
//     String? paymentId,
//     String? errorMessage,
//   }) {
//     return CheckoutState(
//       status: status ?? this.status,
//       selectedPayment: selectedPayment ?? this.selectedPayment,
//       selectedDelivery: selectedDelivery ?? this.selectedDelivery,
//       subtotal: subtotal ?? this.subtotal,
//       deliveryFee: deliveryFee ?? this.deliveryFee,
//       discount: discount ?? this.discount,
//       total: total ?? this.total,
//       paymentId: paymentId ?? this.paymentId,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         status,
//         selectedPayment,
//         selectedDelivery,
//         subtotal,
//         deliveryFee,
//         discount,
//         total,
//         paymentId,
//         errorMessage,
//       ];
// }