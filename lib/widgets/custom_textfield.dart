import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {

  TextEditingController textEditingController=TextEditingController();
  String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String?> validator;
     CustomTextfield({super.key,required this.textEditingController,required this.hintText, required this.obscureText, required this.keyboardType, required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    validator:validator ,
    obscureText: obscureText,
    keyboardType: keyboardType,
      controller:textEditingController ,
    decoration: InputDecoration(border:OutlineInputBorder(borderRadius: BorderRadius.circular(13))),
       
    );
  }
}