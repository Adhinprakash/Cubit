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
        height: 50,
      
        decoration: BoxDecoration(color: Colors.black),
        child: Center(child: buttonWidget),
      ),
    );
  }
}