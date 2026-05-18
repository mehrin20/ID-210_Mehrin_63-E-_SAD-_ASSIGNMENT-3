import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validator;
  final String hintText;
  final String labelText;
  final Widget prefixIcon;
  final TextStyle? labelStyle;
  final bool obscureText;
  final InputBorder? border;
  final InputDecoration? decoration;
  const InputField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.validator,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.labelStyle,
    this.obscureText = false,
    this.border,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,

      validator: validator,
      obscureText: obscureText,
      decoration:
          decoration ??
          InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,

            labelText: labelText,
            labelStyle: labelStyle,
            border:
                border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
          ),
    );
  }
}
