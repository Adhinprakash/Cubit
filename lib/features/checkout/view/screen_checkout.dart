import 'package:flutter/material.dart';

class ScreenCheckout extends StatefulWidget {
  const ScreenCheckout({super.key});

  @override
  State<ScreenCheckout> createState() => _ScreenCheckoutState();
}

class _ScreenCheckoutState extends State<ScreenCheckout> {
    String selectedPayment = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

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
          'Checkout',
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivery location',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Change',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),

                Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.location_pin, color: Colors.blue, size: 40),
                    Text(
                      'putoorkavil,eramanagalam po balussery via kodls',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              Text(
                    'Method of delivery',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  deliveryTypeWidget('Expressdelivery', Colors.blue),
                  deliveryTypeWidget('Expressdelivery', Colors.black),

                  ],),
                  SizedBox(height: 20,),
       const Text(
          'Payment method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF171717),
          ),
        ),

        const SizedBox(height: 14),

paymentMethodWidget(selectedPayment=='card', () {
  setState(() {
    selectedPayment='card';
  });
},'assets/images/mastercard-26161.png'),
SizedBox(height: 10,),
paymentMethodWidget(selectedPayment=='apple', () {
  setState(() {
    selectedPayment='apple';
  });
},'assets/images/png-apple-logo-9713.png'),
SizedBox(height: 10,),

paymentMethodWidget(selectedPayment=='apple', () {
  setState(() {
    selectedPayment='gpay';
  });
},'assets/images/google-plus-png-logo-3704.png'),

SizedBox(height: 10,),

              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF202124),
                ),
              ),

              const SizedBox(height: 16),

              const PriceRow(title: 'Subtotal', price: '\$2,657.99'),

              const SizedBox(height: 12),

              const PriceRow(title: 'Delivery Fee', price: '\$5.00'),

              const SizedBox(height: 12),

              const PriceRow(
                title: 'Discount',

                price: '-\$20.00',
                priceColor: Color(0xFF20B86B),
              ),

              const SizedBox(height: 16),

              const Divider(color: Color(0xFFE4E6E9), height: 1),

              const SizedBox(height: 16),

              const PriceRow(
                title: 'Total',
                price: '\$2,642.99',
                titleWeight: FontWeight.w700,
                priceWeight: FontWeight.w700,
                titleFontSize: 17,
                priceFontSize: 19,
              ),
      
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        decoration: const BoxDecoration(color: Color(0xFFF8F9FA)),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScreenCheckout()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF20B86B),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: 8),
                Text(
                  '•',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Text(
                  '\$2,642.99',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 19),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

  Widget deliveryTypeWidget(String content,Color color){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: color),borderRadius: BorderRadius.circular(12)),
      child: Center(child: Text(content,style: TextStyle(fontSize: 15,color:color),),),
    );
  }
   Widget paymentMethodWidget(final bool isSelected,   final VoidCallback onTap,
  final String imageUrl
){
return  GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2878E8)
                : const Color(0xFFD7D7D7),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
            children: [
             AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? const Color(0xFF2878E8)
              : const Color(0xFFD0D0D0),
          width: isSelected ? 2.5 : 1.5,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF2878E8),
                ),
              ),
            )
          : null,
    ),
              const SizedBox(width: 14),

            Image.asset(
              height: 25,
              width: 25,
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_outlined,
                  color: Color(0xFFB0B2B7),
                  size: 30,
                );
              },
            ),

              const SizedBox(width: 8),

              const Text(
                'Pay',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF555555),
                ),
              ),
            ],
          ),
      ),
    );

  }

}

class PriceRow extends StatelessWidget {
  final String title;
  final String price;
  final Color? priceColor;
  final FontWeight titleWeight;
  final FontWeight priceWeight;
  final double titleFontSize;
  final double priceFontSize;

  const PriceRow({
    super.key,
    required this.title,
    required this.price,
    this.priceColor,
    this.titleWeight = FontWeight.w400,
    this.priceWeight = FontWeight.w500,
    this.titleFontSize = 14,
    this.priceFontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: titleWeight,
            color: const Color(0xFF777A82),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: priceFontSize,
            fontWeight: priceWeight,
            color: priceColor ?? const Color(0xFF202124),
          ),
        ),
      ],
    );
  }
 
}

