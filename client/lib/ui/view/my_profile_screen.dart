import 'dart:convert';
import 'package:client/common/const/app_colors.dart';
import 'package:client/common/utils/auth_storage.dart';
import 'package:client/common/widgets/confirm_dialog.dart';
import 'package:client/common/widgets/custom_profile_button.dart';
import 'package:client/common/widgets/modify_dialog.dart';
import 'package:client/common/widgets/my_profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyProfileScreen extends StatefulWidget {
  static String routeName = '/my-profile';

  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String nickname = '지니신'; // 초기 닉네임
  String email = '';
  String photoUrl = '';
  String userId = '';

  @override
  void initState() {
    super.initState();
    _initializeUserId();
  }

  Future<void> _initializeUserId() async {
    final id = await AuthStorage.getUserId();
    setState(() {
      userId = id!;
    });
    await _fetchUserProfile(userId); // userId를 이용하여 사용자 프로필 정보를 가져옴
  }

  Future<void> _fetchUserProfile(String userId) async {
    final url = Uri.parse('http://143.248.191.30:3000/user/profile/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Response body: ${response.body}'); // 응답 본문을 출력하여 확인
      final jsonResponse = json.decode(response.body);
      final user = jsonResponse['user'];
      setState(() {
        nickname = user['displayName'];
        email = user['email'];
        photoUrl = user['photoUrl'];
      });
    } else {
      // 오류 처리
      print('Failed to load user profile');
    }
  }

  Future<void> _updateNickname(String newNickname) async {
    final url = Uri.parse('http://143.248.191.30:3000/user/profile/$userId');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'displayName': newNickname}),
    );

    if (response.statusCode == 200) {
      setState(() {
        nickname = newNickname;
      });
    } else {
      // 오류 처리
      print('Failed to update nickname');
    }
  }

  void _logout() {
    Navigator.of(context).pushReplacementNamed('/login'); // 로그인 화면으로 이동
  }

  void _cancle() {
    showCancleConfirmDialog(context);
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
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.faintGray,
                backgroundImage: photoUrl.isNotEmpty
                    ? NetworkImage(photoUrl) // URL을 통해 프로필 이미지 로드
                    : const AssetImage('asset/profile_image.png') as ImageProvider, // 기본 로컬 이미지 사용
              ),
              const SizedBox(height: 20),
              MyProfileListTile(
                enabled: false,
                title: '닉네임: $nickname',
                trailing: CustomProfileButton(
                  onTap: () async {
                    String? newNickname = await showModifyNicknameDialog(context, nickname);
                    if (newNickname != null && newNickname.isNotEmpty) {
                      await _updateNickname(newNickname);
                    }
                  },
                  text: "수정하기",
                ),
              ),
              MyProfileListTile(
                enabled: false,
                title: '이메일: $email',
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