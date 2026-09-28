import 'package:cubit/features/favorites/cubit/favorite_cubit.dart';
import 'package:cubit/model/product_model.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetails extends StatefulWidget {
  final Products product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    bool isfav= context.select<FavoriteCubit,bool>((cubit)=>cubit.isFav(widget.product.id.toString()));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 400,

            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    widget.product.thumbnail??'',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: topPadding,
                    left: 16,
                    child: topWidgetcontainers(
                      Icons.arrow_back_ios,
                      () =>          Navigator.pop(context)
,Colors.black
                    ),
                  ),
                  Positioned(
                    top: topPadding,
                    right: 16,
                    child: topWidgetcontainers(Icons.favorite, () => 
                      context.read<FavoriteCubit>().toggleFavorite(widget.product.id.toString())
                    ,isfav?Colors.red:Colors.black),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.product.category??'N/A',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  Text(
                    widget.product.title??'',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Brand: '),
                      Text( widget.product.brand??'', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      textContainer( '${ widget.product.rating.toString()}', Icons.star, Colors.yellow),
                      SizedBox(width: 10),

                      SizedBox(width: 10),
                      Text(
                        '${ widget.product.reviews?.length.toString()} reviews',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$${ widget.product.price??''}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${ widget.product.discountPercentage??''}%',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    widget.product.description??'',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),

                  SizedBox(height: 10),
                  Row(
                    spacing: 10,
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: Text('Color')),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                      ),

                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(child: Text('')),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Top reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Column(children: widget.products!.reviews!.map((review)=>revieWidget(review)).toList(),)
                  Text(
                    'Product Tags',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    spacing: 10,
                    children:widget.product.tags?.map((e)=>tagContainer(e)).toList()??[]
                  ),
                  SizedBox(height: 25),
                  productDetailsContainer(widget.product),
                  SizedBox(height: 25),

                  stockContainer(),
                  SizedBox(height: 25),
                  shippingWarnatyContainer(),
                  SizedBox(height: 25),
                  productInfo(widget.product),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cartCountWidget(),
            CustomButton(
              ontap: () {},
              buttonWidget: Text(
                'Add to cart',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textContainer(String content, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor),
          Text(content, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget revieWidget(Reviews review) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  review.reviewerName.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return Icon(Icons.star, color: Colors.orangeAccent, size: 15);
              }),
            ),

            Text(
              'Great',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(review.comment!),
          ],
        ),
      ),
    );
  }

  Widget topWidgetcontainers(IconData icon, VoidCallback fucntion,Color iconColor) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: IconButton(onPressed:fucntion, icon: Icon(icon,color: iconColor,)),
    );
  }
}

Widget cartCountWidget() {
  return Container(
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(),
    ),
    child: Row(
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.remove)),
        Text('1', style: TextStyle(color: Colors.black)),
        IconButton(onPressed: () {}, icon: Icon(Icons.add)),
      ],
    ),
  );
}

Widget tagContainer(String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.deepPurple[100],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      title,
      style: TextStyle(color: Colors.deepPurple, fontSize: 12),
    ),
  );
}

Widget productDetailsContainer(Products product) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(width: 0.4),
    ),
    child: Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        _detailRow(title: 'SKI', value: product.sku ?? '-'),
        Divider(),
        _detailRow(title: 'Weight', value: '${product.weight ?? 0} g'),

        Divider(),
        _detailRow(
            title: 'Dimensions',
            value:
                'Width: ${product.dimensions?.width ?? 0} cm  |  '
                'Height: ${product.dimensions?.height ?? 0} cm  |  '
                'Depth: ${product.dimensions?.depth ?? 0} cm',
          ),

 Divider(),
          _detailRow(
            title: 'Minimum Order\nQuantity',
            value: '${product.minimumOrderQuantity ?? 0}',
          ),
      ],
    ),
  );
}


  Widget _infoRow({
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff667085),
            ),
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff344054),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
Widget _detailRow({
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff667085),
            ),
          ),
        ),

        Expanded(
          flex: 4,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff344054),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }


Widget stockContainer() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
    height: 70,
    decoration: BoxDecoration(
      color: Colors.green[100],
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      
      spacing: 10,
      children: [
        CircleAvatar(
          child: Center(child: Icon(Icons.inventory, color: Colors.green)),
          backgroundColor: Colors.green[200],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('In stock', style: TextStyle(color: Colors.green)),
            Text('Ready to-ship', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}

Widget shippingWarnatyContainer() {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(width: 0.4),
    ),
    child: Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'shipping & warranty',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          spacing: 30,
          children: [
            Icon(Icons.local_shipping_outlined, size: 18, color: Colors.black),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shipping information',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ship in 3-5 bussiness days',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(),

        Row(
          spacing: 30,

          children: [
            Icon(Icons.shield, size: 18, color: Colors.black),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  'Shipping information',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ship in 3-5 bussiness days',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget returnPolicyWidget() {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(width: 0.4),
    ),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
          child: Center(
            child: Icon(
              Icons.replay_circle_filled_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget productInfo(Products product) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(13),
      border: Border.all(width: 0.4),
    ),
    child: Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
          const SizedBox(height: 14),

          _infoRow(
            title: 'Category',
            value: product.category ?? '-',
          ),

        Divider(),

          _infoRow(
            title: 'Brand',
            value: product.brand ?? '-',
          ),

        Divider(),

          _infoRow(
            title: 'Tags',
            value: product.tags?.join(', ') ?? '-',
          ),

        Divider(),

          _infoRow(
            title: 'SKU',
            value: product.sku ?? '-',
          ),

        Divider(),

          _infoRow(
            title: 'Barcode',
            value: product.meta?.barcode ?? '-',
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.qr_code_2,
                size: 32,
                color: Color(0xff344054),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Text(
                  'QR Code',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff667085),
                  ),
                ),
              ),
Expanded(
  child: Container(
    height: 40,
  
    child: Image.network(product.meta?.qrCode??'',fit: BoxFit.contain)),
),
              const Icon(
                Icons.chevron_right,
                color: Color(0xff667085),
              ),
            ],
          ),
      ],
    ),
  );
}
