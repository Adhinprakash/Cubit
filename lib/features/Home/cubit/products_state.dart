import 'package:cubit/model/product_model.dart';
import 'package:equatable/equatable.dart';

enum ProductsStaus { initial, loading, loaded, failed }

class ProductsState extends Equatable {
  final ProductsStaus status;
  final List<Products> products;
  final String errormessage;

  ProductsState({
    this.status = ProductsStaus.initial,
    this.products = const [],
    this.errormessage = '',
  });

  ProductsState copyWith({
    ProductsStaus? status,
    List<Products>? products,
    String? errormessage,
  }) {
    return ProductsState(
      status: status?? this.status,
      products:products?? this.products,
      errormessage:errormessage?? this.errormessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errormessage, products];
}
