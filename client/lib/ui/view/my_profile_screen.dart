import 'package:client/common/const/app_colors.dart';
import 'package:client/common/widgets/confirm_dialog.dart';
import 'package:client/common/widgets/custom_profile_button.dart';
import 'package:client/common/widgets/modify_dialog.dart';
import 'package:client/common/widgets/my_profile_list_tile.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  static String routeName = '/my-profile';

  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String nickname = '지니신'; // 초기 닉네임

  void _logout() {
    Navigator.of(context).pushReplacementNamed('/login'); // 로그인 화면으로 이동
  }

  void _cancle() {
    showCancleConfirmDialog(context);
  }

  void _updateNickname(String newNickname) {
    setState(() {
      nickname = newNickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.faintGray,
                backgroundImage:
                    AssetImage('asset/profile_image.png'), // 로컬 이미지 경로
              ),
              const SizedBox(height: 20),
              MyProfileListTile(
                enabled: false,
                title: '닉네임: $nickname',
                trailing: CustomProfileButton(
                  onTap: () async {
                    String? newNickname =
                        await showModifyNicknameDialog(context, nickname);
                    if (newNickname != null && newNickname.isNotEmpty) {
                      _updateNickname(newNickname);
                    }
                  },
                  text: "수정하기",
                ),
              ),
              MyProfileListTile(
                onTap: _logout,
                title: '로그아웃',
                textAlign: TextAlign.right, // 오른쪽 정렬
              ),
              MyProfileListTile(
                onTap: _cancle,
                title: '회원탈퇴',
                textAlign: TextAlign.right, // 오른쪽 정렬
              ),
            ],
          ),
        ),
      ),
    );
  }
}
