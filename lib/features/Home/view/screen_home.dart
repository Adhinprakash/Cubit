import 'package:carousel_slider/carousel_slider.dart';
import 'package:cubit/const/const.dart';
import 'package:cubit/features/Home/cubit/products_cubit.dart';
import 'package:cubit/features/Home/cubit/products_state.dart';
import 'package:cubit/features/Home/view/screen_product_details.dart';
import 'package:cubit/features/cart/view/screen_cart.dart';
import 'package:cubit/features/favorites/view/screen_fav.dart';
import 'package:cubit/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductsCubit>().getallProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: const Color(0xFFF8F9FA),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            homeTextFormField(),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenCart(),)),
              child: Container(
                height: 40,
                width: 40,
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 27,
                    color: Colors.black,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
             Expanded(
               child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenFav(),)),
                 child: Container(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.favorite,
                      size: 27,
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2),
                    color: Colors.white,
                    shape: BoxShape.circle,
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
              decoration: BoxDecoration(
               
              ),
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Column(
                  children: [
                    // homeCarouselWidget(carouselImages),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('categories',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                          Text('see all',style: TextStyle(color: Colors.green,fontSize: 14,fontWeight: FontWeight.bold,),)
                
                    ],),
                    Expanded(
                      flex: 0,
                      child: SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final List categorylist = [];
                            categorylist.add(state.products[index].category);
                
                            debugPrint("${categorylist}---------");
                
                            return state.status == ProductsStaus.loaded
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: categoryWidget(
                                      // catergoryText: '${products[index].category}',
                                    ),
                                  )
                                : Container(child: Text('data'));
                          },
                        ),
                      ),
                    ),
                    Expanded(child: gridviewLayoutCard()),
                
                    Row(children: []),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget homeTextFormField() {
    return Container(
      height: 46,
      width: 300,
      decoration: BoxDecoration(
    color: const Color(0xFFF1F2F2),
    borderRadius: BorderRadius.circular(11),
      ),
      child: const TextField(
    textAlignVertical: TextAlignVertical.center,
    decoration: InputDecoration(
      hintText: 'Search',
      hintStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF9A9A9A),
      ),
      border: InputBorder.none,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      suffixIcon: Icon(
        Icons.search,
        size: 23,
        color: Color(0xFF222222),
      ),
      suffixIconConstraints: BoxConstraints(
        minWidth: 48,
        minHeight: 46,
      ),
    ),
      ),
    );
  }
  Widget homeCarouselWidget( List<String> images) {
    return SizedBox(child: CarouselSlider(items: carouselImages.map((image)=>Container(  decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            child: Image.network(image) ,
                            width: double.infinity,)).toList(), options: CarouselOptions(      height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,)),);

  }

  Widget categoryWidget({String? catergoryText}) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 25),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('$catergoryText')),
    );
  }

  Widget gridviewLayoutCard(){
    return GridView.builder(
      itemCount: carouselImages.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final products =
        carouselImages[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(),)),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                   Container(
                    height: 190,
                  decoration: BoxDecoration(   color: const Color(0xFFF1F2F2),
borderRadius: BorderRadius.circular(16)),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ClipRRect (
                        
                          child: Image.network(
                            products
                          ),
                        ),
                     ),
                   ),
                    Text(
                      "N/A",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,

                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'mfmfm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.green,size: 14,),
                        Text(''),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 10,
            //   left: 6,

            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.circular(
            //         12,
            //       ),
            //     ),
            //     child: Center(
            //       child: Text(
            //         // "${products.discountPercentage.toString()}%",
            //         'ddfdk',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 12,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
