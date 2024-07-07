import 'package:client/common/const/app_colors.dart';
import 'package:client/common/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width / 2, 50),
        backgroundColor: AppColors.faintGray,
      ),
      child: Text(
        text,
        style: elevatedBtnTextStyle,
      ),
    );
  }
}
