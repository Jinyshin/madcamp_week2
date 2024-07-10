import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String?> showModifyNicknameDialog(
    BuildContext context, String nickname) async {
  TextEditingController nicknameController = TextEditingController();
  nicknameController.text = nickname;

  return await showDialog<String>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '닉네임을 입력해 주세요.',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: TextField(
          controller: nicknameController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              String newNickname = nicknameController.text;
              if (newNickname.isNotEmpty) {
                await modifyNickname(newNickname);
                Navigator.of(context).pop(newNickname);
              } else {
                // 닉네임이 비어있는 경우 처리 (예: 오류 메시지 표시)
                Navigator.of(context).pop();
              }
            },
            child: const Text('저장'),
          ),
        ],
      );
    },
  );
}

// TODO: Move code
Future<bool> modifyNickname(String newNickname) async {
  const url = 'http://localhost/modify-nickname'; // TODO: 실제 서버 URL로 변경
  Dio dio = Dio();
  try {
    final response = await dio.post(url, data: {
      'userId': '67890', // 실제 userId로 변경
      'newNickname': newNickname,
    });
    if (response.statusCode == 200) {
      print('닉네임이 변경되었습니다.');
      return true;
    } else {
      print('서버 오류: ${response.statusCode}');
      return false;
    }
  } catch (e) {
    print('예외 발생: $e');
    return false;
  }
}
