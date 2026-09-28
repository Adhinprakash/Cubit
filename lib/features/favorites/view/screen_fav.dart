import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/Home/view/screen_product_details.dart';
import 'package:cubit/features/favorites/cubit/favorite_cubit.dart';
import 'package:cubit/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenFav extends StatelessWidget {
  const ScreenFav({super.key});

  @override
  Widget build(BuildContext context) {
                          final favList= context.watch<FavoriteCubit>().state.favIdsList.toList();

    return Scaffold(
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
          'Favorites',
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
         backgroundColor: const Color(0xFFF8F9FA),

      body: SafeArea(
        child:BlocBuilder<ProductsCubit,ProductsState>(builder: (context, state) {
                            final favoriteProducts=state.visibleproducts.where((e)=>favList.contains(e.id.toString())).toList();

          return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 20),
          child: Column(
            children: [
          Expanded(child: ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {

            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product:favoriteProducts[index]),)),
              child: favItem(favoriteProducts[index],context));
          },))
            ],
          ),
        );
        },)
      ),
    );
  }


  Widget favItem(
   Products prouduct,
   BuildContext context
   ){
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
                prouduct.thumbnail??'',
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
                          prouduct.title??'',
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

                      Builder(
                        builder: (context) {
                                                bool isFav=                  context.select((FavoriteCubit c)=>c.isFav(prouduct.id.toString()));

                          return GestureDetector(
                            onTap: () {
                              context.read<FavoriteCubit>().toggleFavorite(prouduct.id.toString());
                            },
                            child:  Icon(
                             isFav? Icons.favorite:Icons.favorite_border,
                             size: 20,
                             color:isFav?Colors.red:Colors.transparent,
                             
                            ),
                          );
                        }
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                   prouduct.brand??'',
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
                        '\$${prouduct.price.toString()}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF202124),
                        ),
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