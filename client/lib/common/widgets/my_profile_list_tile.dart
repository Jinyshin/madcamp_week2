import 'package:flutter/material.dart';

class MyProfileListTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Widget? trailing;
  final bool enabled;
  final TextAlign textAlign;

  const MyProfileListTile({
    required this.title,
    this.onTap,
    this.trailing,
    this.enabled = true,
    this.textAlign = TextAlign.left, // 기본값은 왼쪽 정렬
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListTile(
            title: Text(
              title,
              textAlign: textAlign,
            ),
            onTap: enabled ? onTap : null,
            trailing: trailing,
          ),
          Divider(
              color: Colors.grey
                  .withOpacity(0.3)), // AppColors.faintGray을 사용하는 경우 해당 색상으로 변경
        ],
      ),
    );
  }
}
