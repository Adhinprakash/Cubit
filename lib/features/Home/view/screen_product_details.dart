import 'package:cubit/model/product_model.dart';
import 'package:cubit/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,

            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    'https://i.pinimg.com/736x/d7/93/87/d79387bfc2e42110f54f7594f7fb15bc.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: topPadding,
                    left: 16,
                    child: topWidgetcontainers(
                      Icons.arrow_back_ios,
                      () => Navigator.pop,
                    ),
                  ),
                  Positioned(
                    top: topPadding,
                    right: 16,
                    child: topWidgetcontainers(Icons.favorite, () => {}),
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
                    child: Text(
                      'Beauty',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Text(
                    'Title',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text('Brand: '),
                      Text('Essence', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      textContainer('4.8', Icons.star, Colors.yellow),
                      SizedBox(width: 10),

                      SizedBox(width: 10),
                      Text(
                        '(117 reviews)',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "S 9.99",
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
                        child: Text(
                          '10.45% off',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    "Developed a full-featured e-commerce application with Firebase authentication, RESTful product APIs, product search and filtering, wishlist, cart management, checkout, and order tracking. Implemented Cubit-based state management, Firestore persistence, pagination, and Firebase Cloud Messaging for order notifications.",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
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
                    children: [tagContainer('beauty'), tagContainer('mascara')],
                  ),
                  SizedBox(height: 10),
                  productDetailsContainer(),
                  SizedBox(height: 10),

                  stockContainer(),
                  SizedBox(height: 10),
                  shippingWarnatyContainer(),
                  SizedBox(height: 10,),
productInfo()

                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
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

  Widget topWidgetcontainers(IconData icon, Function fucntion) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: IconButton(onPressed: () => fucntion, icon: Icon(icon)),
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

Widget productDetailsContainer() {
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
        Row(spacing: 30, children: [Text('SKU'), Text('BEA-ESS-ESS-001')]),
        Divider(),

        Row(spacing: 30, children: [Text('SKU'), Text('BEA-ESS-ESS-001')]),
        Divider(),
        Row(
          spacing: 30,
          children: [Text('Dimension'), Text('BEA-ESS-ESS-001')],
        ),
      ],
    ),
  );
}

Widget stockContainer() {
  return Container(
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


Widget returnPolicyWidget(){

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
          decoration: BoxDecoration(color: Colors.grey,shape: BoxShape.circle,),
          child: Center(child: Icon(Icons.replay_circle_filled_outlined,color: Colors.black,),),
        )
      ],
    ),
  );
}

Widget productInfo(){
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
        Row(spacing: 30, children: [Text('SKU'), Text('BEA-ESS-ESS-001')]),
        Divider(),

        Row(spacing: 30, children: [Text('SKU'), Text('BEA-ESS-ESS-001')]),
        Divider(),
        Row(
          spacing: 30,
          children: [Text('Dimension'), Text('BEA-ESS-ESS-001')],
        ),
                Divider(),

         Row(
          spacing: 30,
          children: [Row(
            children: [
              Icon(Icons.qr_code_2_rounded,color: Colors.black,),
              Text('Qr code'),

            ],
          ), Text('BEA-ESS-ESS-001')],
        ),
      ],
    ),
  );
}