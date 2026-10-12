import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubit/const/const.dart';
import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/Home/view/screen_product_details.dart';
import 'package:cubit/features/cart/cubit/cart_cubit.dart';
import 'package:cubit/features/cart/view/screen_cart.dart';
import 'package:cubit/features/favorites/cubit/favorite_cubit.dart';
import 'package:cubit/features/favorites/view/screen_fav.dart';
import 'package:cubit/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(248, 249, 250, 1),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: HomeSearchField()),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScreenCart()),
              ),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 27,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScreenFav()),
                ),
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(Icons.favorite, size: 27, color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: Container(),
        actions: [],
        toolbarHeight: 100,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [


                    homeCarouselWidget(carouselImages),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'categories',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'see all',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) {
                            return state.status == ProductsStaus.loading
                                ? categoryShimmer()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () => context
                                          .read<ProductsCubit>()
                                          .selectCategory(
                                            state.categories[index] ?? '',
                                          ),
                                      child: categoryWidget(
                                        state: state,
                                        catergoryText:
                                            '${state.categories[index]}',
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    state.status == ProductsStaus.loading
                        ? Expanded(child: productGridShimmer())
                        : Expanded(child: gridviewLayoutCard(state)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homeCarouselWidget(List<String> images) {
    return SizedBox(
      child: CarouselSlider(

        items: images
            .map(
              (image) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Image.network(image,fit: BoxFit.fill,),
                width: double.infinity,
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 180.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }

  Widget categoryWidget({String? catergoryText, ProductsState? state}) {
    final bool isSelected = state?.selectedCategory == catergoryText;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        gradient: isSelected
            ? const LinearGradient(
                colors: [Color(0xFF43A047), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.green.withOpacity(0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 0.3,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : Colors.grey.shade800,
          ),
          child: Text(catergoryText ?? ''),
        ),
      ),
    );
  }

  Widget categoryShimmer() {
    return Shimmer.fromColors(
      child: Container(
        height: 44,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }

  Widget gridviewLayoutCard(ProductsState state) {
    return GridView.builder(
      itemCount: state.visibleproducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final product = state.visibleproducts[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetails(product: product),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 190,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F2F2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          child: Image.network(product.thumbnail ?? ''),
                        ),
                      ),
                    ),
                    Text(
                      product.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        color: Color(0xFF777A82),

                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Color(0xFFFF640A), size: 14),
                        Text('${product.rating}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) {
                bool isFav = context.select(
                  (FavoriteCubit c) => c.isFav(product.id.toString()),
                );

                return Positioned(
                  top: 10,
                  right: 15,

                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<FavoriteCubit>().toggleFavorite(
                          product.id.toString(),
                        );
                      },
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              left: 6,

              child: Container(
                height: 20,
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "${product.discountPercentage.toString()}%",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget productGridShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    height: 14,
                    width: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Container(
                        height: 14,
                        width: 14,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 10,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Positioned(
              top: 10,
              right: 15,
              child: Container(
                height: 38,
                width: 38,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            Positioned(
              top: 10,
              left: 6,
              child: Container(
                height: 20,
                width: 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Products>(
      displayStringForOption: (product) {
        return product.title ?? '';
      },

      optionsBuilder: (TextEditingValue textEditingValue) {
        final query = textEditingValue.text.trim().toLowerCase();

        if (query.isEmpty) {
          return const Iterable<Products>.empty();
        }

        final products = context.read<ProductsCubit>().state.products;

        final results = products
            .where((product) {
              final title = product.title?.toLowerCase() ?? '';

              final category = product.category?.toLowerCase() ?? '';

              final brand = product.brand?.toLowerCase() ?? '';

              return title.contains(query) ||
                  category.contains(query) ||
                  brand.contains(query);
            })
            .take(6);

        return results;
      },

      onSelected: (Products product) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },

      fieldViewBuilder:
          (
            BuildContext context,
            TextEditingController controller,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted,
          ) {
            return TextFormField(
              controller: controller,
              focusNode: focusNode,

              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),

                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),

              textInputAction: TextInputAction.search,

              onFieldSubmitted: (value) {
                onFieldSubmitted();
              },
            );
          },

      optionsViewBuilder:
          (
            BuildContext context,
            AutocompleteOnSelected<Products> onSelected,
            Iterable<Products> options,
          ) {
            return Align(
              alignment: Alignment.topLeft,

              child: Material(
                elevation: 5,
                color: Colors.white,

                borderRadius: BorderRadius.circular(2),

                child: SizedBox(
                  width: 500,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,

                    itemCount: options.length,

                    itemBuilder: (context, index) {
                      final product = options.elementAt(index);

                      return InkWell(
                        onTap: () {
                          onSelected(product);
                        },

                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),

                          child: Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 45,
                                child: Image.network(
                                  product.thumbnail ?? '',
                                  fit: BoxFit.contain,

                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.image_not_supported_outlined,
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Text(
                                      product.title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      'in ${product.category ?? ''}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
    );
  }
}
