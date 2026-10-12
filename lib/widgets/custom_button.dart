import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
    final Function ontap;
    final Widget buttonWidget;

  const CustomButton({super.key, required this.ontap, required this.buttonWidget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        ontap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal:12,vertical: 6),
        height: 50,
      
        decoration: BoxDecoration(color: Color(0xFF20B86B),shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(15)),
        
        child: Center(child: buttonWidget),
      ),
    );
  }
}
 