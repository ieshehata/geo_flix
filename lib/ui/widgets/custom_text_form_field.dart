import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.text,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.onChange,
    this.onTap,
    this.suffixPress,
    this.onSubmitted,
    this.validator,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String text;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final Function(String)? onChange;
  final Function()? onTap;
  final Function()? suffixPress;
  final Function(String)? onSubmitted;
  final String? Function(String? val)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
          fontSize: 19,
          color: dashBoardColor,
        ),
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        label: Text(text),
        prefixIcon: Icon(
          prefixIcon,
          color: dashBoardColor,
        ),
        suffixIcon: IconButton(
          onPressed: suffixPress,
          icon: Icon(suffixIcon),
          color: dashBoardColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF707070), width: .5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF707070), width: .5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFF707070), width: .5)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.red, width: .6),
        ),
      ),
      cursorColor: dashBoardColor,
      style: const TextStyle(
        fontSize: 16,
        color: dashBoardColor,
      ),
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      validator: validator,
    );
  }
}
