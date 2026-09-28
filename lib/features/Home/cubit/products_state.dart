import 'package:cubit/model/product_model.dart';
import 'package:equatable/equatable.dart';

enum ProductsStaus { initial, loading, loaded, failed }

class ProductsState extends Equatable {
  final ProductsStaus status;
  final List<Products> products;
  final String errormessage;
  final String selectedCategory;

  ProductsState({
    this.status = ProductsStaus.initial,
    this.products = const [],
    this.errormessage = '',
    this.selectedCategory='All'
  });

  ProductsState copyWith({
    ProductsStaus? status,
    List<Products>? products,
    String? errormessage,
    String? selectedCategory,
    
  }) {
    return ProductsState(
      status: status?? this.status,
      products:products?? this.products,
      errormessage:errormessage?? this.errormessage,
      selectedCategory:selectedCategory?? this.selectedCategory
    );
  }



  @override
  // TODO: implement props
  List<Object?> get props => [status, errormessage, products,selectedCategory];

  List<String?> get categories {
  final uniqueCategories= products
      .map((product) => product.category)
      .toSet()
      .toList();

      return ['All',...uniqueCategories];
}
  List<Products> get visibleproducts {
if(selectedCategory=='All'){
  return products;
}
return products.where((product)=>product.category==selectedCategory).toList();
}
}
