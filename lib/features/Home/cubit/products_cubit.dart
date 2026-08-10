import 'package:bloc/bloc.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/Home/repository/products_repository.dart';

class ProductsCubit extends Cubit<ProductsState>{
  final ProductsRepository repository;
  ProductsCubit({required this.repository}):super(ProductsState());


  Future<void>getallProducts()async{
    emit(state.copyWith(status: ProductsStaus.loading));

   final allproducts= await repository.getallproducts();
try{
emit(state.copyWith(products: allproducts.products,status: ProductsStaus.loaded));

}catch(e){
emit(state.copyWith(errormessage: e.toString()));
}
  }
}