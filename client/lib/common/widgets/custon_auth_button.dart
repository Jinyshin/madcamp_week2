import 'package:client/common/const/app_colors.dart';
import 'package:client/common/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAuthButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomAuthButton({
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
        maximumSize: Size(width * 0.8, 50),
        foregroundColor: AppColors.darkGray,
        backgroundColor: AppColors.faintGray,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'asset/google_logo.svg',
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: elevatedBtnTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
