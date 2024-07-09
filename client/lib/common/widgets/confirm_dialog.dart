import 'package:client/ui/view/login_screen.dart';
import 'package:client/ui/view/main_menu_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void showCancleConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '회원 탈퇴',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: const Text('모든 게임 기록이 영구삭제됩니다. \n정말로 탈퇴하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () async {
              await leaveRoom();
              // TODO: 회원탈퇴 처리 로직 추가
              Navigator.of(context).pushNamedAndRemoveUntil(
                SignUpScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('탈퇴'),
          ),
        ],
      );
    },
  );
}

void showLeaveRoomConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          '이 방에서 나가시겠습니까?',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
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
              await leaveRoom();

              Navigator.of(context).pushNamedAndRemoveUntil(
                MainMenuScreen.routeName,
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('나가기'),
          ),
        ],
      );
    },
  );
}

// TODO: Move code
Future<void> leaveRoom() async {
  const url = 'http://localhost/leave-room'; // TODO: 실제 서버 URL로 변경
  Dio dio = Dio();
  try {
    final response = await dio.post(url, data: {
      'roomId': '12345', // 실제 roomId로 변경
      'userId': '67890', // 실제 userId로 변경
    });
    if (response.statusCode == 200) {
      print('방을 나갔습니다.');
    } else {
      print('서버 오류: ${response.statusCode}');
    }
  } catch (e) {
    print('예외 발생: $e');
  }
}
