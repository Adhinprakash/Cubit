import 'package:bloc/bloc.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/favorites/cubit/favorite_state.dart';
import 'package:cubit/features/favorites/repository/fav_repository.dart';

class FavoriteCubit extends Cubit<FavoriteState>{
  final FavRepository  favRepository;

  FavoriteCubit({required this.favRepository}) : super(FavoriteState());

Future<void>loadAllFavorites()async{

 final Set<String>ids= await favRepository.fetchFavIds();
 emit(state.copyWith(favList: ids));
}

  Future<void>toggleFavorite(String productId)async{
 final oldFavlist={...state.favList};

 final favCopyset={...state.favList};
try {
  
if(!favCopyset.contains(productId)){
favCopyset.add(productId);
emit(state.copyWith(favList:favCopyset));

await favRepository.addFavorite(productId);

 
}else{
  favCopyset.remove(productId);
  emit(state.copyWith(favList:favCopyset));

await favRepository.removeFavorite(productId);

}
  
} catch (e) {
  emit(state.copyWith(errormessage: e.toString(),favList:oldFavlist ,status: Favstatus.loaded));
}
  }
  
  bool isFav(String productId){
 return state.favList.contains(productId); 
}
  }