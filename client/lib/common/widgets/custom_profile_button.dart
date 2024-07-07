import 'package:client/common/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomProfileButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: Size(width / 4, 50),
        padding: const EdgeInsets.only(
            left: 16, top: 8, bottom: 8, right: 0), // 오른쪽 padding을 0으로 설정
      ),
      child: Text(
        text,
        style: whiteTextBtnTextStyle,
      ),
    );
  }
}
