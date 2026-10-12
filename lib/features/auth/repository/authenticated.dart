import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/cart/cubit/cart_cubit.dart';
import 'package:cubit/features/favorites/cubit/favorite_cubit.dart';
import 'package:cubit/widgets/bottom_navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Authenticated extends StatefulWidget {
  const Authenticated({super.key});

  @override
  State<Authenticated> createState() => _AuthenticatedState();
}

class _AuthenticatedState extends State<Authenticated> {

  @override
  void initState() {
    // TODO: implement initState
   

    super.initState();
      context.read<ProductsCubit>().getallProducts();
    context.read<FavoriteCubit>().loadAllFavorites();
        context.read<CartCubit>().fetchAllCartitems();
  }
  @override
  Widget build(BuildContext context) {
    return NavigationPages();
  }
}