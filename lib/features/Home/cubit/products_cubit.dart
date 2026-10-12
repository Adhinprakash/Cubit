import 'package:bloc/bloc.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/Home/repository/products_repository.dart';
import 'package:cubit/model/product_model.dart';

class ProductsCubit extends Cubit<ProductsState>{
  final ProductsRepository repository;
  ProductsCubit({required this.repository}):super(ProductsState());

  Future<void>getallProducts()async{
    emit(state.copyWith(status: ProductsStaus.loading));

   final allproducts= await repository.getallproducts();
try{
emit(state.copyWith(products: allproducts.products,status: ProductsStaus.loaded));

}catch(e){
emit(state.copyWith(status: ProductsStaus.failed,errormessage: e.toString()));
}
  }


void serachProducts(String query){
  if(query.trim().isEmpty){
    emit(state.copyWith(products:[] ));
    return;
  }
final searchquery =query.trim().toLowerCase();


final result= state.products.where((product){

  final title=product.title?.toLowerCase()??'';
  final brand=product.brand?.toLowerCase()??'';
 final category=product.category?.toLowerCase()??'';

 return (title.contains(searchquery))||(brand.contains(searchquery))||(category).contains(searchquery);
}).toList();

emit(state.copyWith(products: result));
}


 void selectCategory(String category){
  emit(state.copyWith(selectedCategory: category));
 }
}