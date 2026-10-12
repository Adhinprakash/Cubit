import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomTextfield({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  
      controller: textEditingController,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      cursorColor: const Color(0xFF20B86B),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? const Color(0xFF20B86B)
                : Colors.grey.shade500),
        suffixIconColor: Colors.grey.shade500,
        filled: true,
        fillColor: const Color(0xFFF5F6F8),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        enabledBorder: _border(Colors.transparent),
        focusedBorder: _border(const Color(0xFF20B86B), 1.5),
        errorBorder: _border(Colors.red.shade400),
        focusedErrorBorder: _border(Colors.red.shade400, 1.5),

      
      ),
    );
  }
}