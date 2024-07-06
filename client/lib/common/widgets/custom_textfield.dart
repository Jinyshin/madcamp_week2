import 'package:client/common/const/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      controller: controller,
      decoration: InputDecoration(
        fillColor: AppColors.bgColor,
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
