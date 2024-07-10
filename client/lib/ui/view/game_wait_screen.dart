import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/ui/view/game/dudeoji_game_screen.dart';
import 'package:client/ui/view/game/image_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameWaitScreen extends StatefulWidget {
  static const routeName = '/game-wait';
  final String title;
  final String gameId;

  const GameWaitScreen({
    super.key,
    required this.title,
    required this.gameId,
  });

  @override
  _GameWaitScreenState createState() => _GameWaitScreenState();
}

class _GameWaitScreenState extends State<GameWaitScreen> {
  int myHighScore = 0; // 초기 최고 점수는 0으로 설정, 서버에서 가져올 예정
  String gameRules = '게임 설명을 불러오는 중입니다...'; // 기본 게임 설명

  @override
  void initState() {
    super.initState();
    fetchHighScoreAndRules(); // 화면이 처음 생성될 때 최고 점수와 게임 설명을 가져오는 함수 호출
  }

  // 최고 점수와 게임 설명을 서버에서 가져오는 함수
  Future<void> fetchHighScoreAndRules() async {
    const userId = '668e1d4ce7359531484f8731'; // 고정 사용자 ID
    final gameId = widget.gameId; // 위젯에서 전달받은 게임 ID

      // 실제 API 엔드포인트로 교체해야 함
    String highScoreUrl = 'http://143.248.191.30:3000/score/max-score/$userId/$gameId';
    const gameInfoUrl = 'http://143.248.191.30:3000/games';

    try {
      // 최고 점수 가져오기
      if (gameId == '1' || gameId == '668c2506bfaa70b1e661ce42') {
        highScoreUrl = 'http://143.248.191.30:3000/score/max-score/668e1d4ce7359531484f8731/668c2506bfaa70b1e661ce42';
      }
      
      final highScoreResponse = await http.get(Uri.parse(highScoreUrl));
      if (highScoreResponse.statusCode == 200) {
        final highScoreData = json.decode(highScoreResponse.body);
        print('High score data: $highScoreData'); // 서버 응답 확인
        if (highScoreData.containsKey('maxScore')) {
          setState(() {
            myHighScore = highScoreData['maxScore']; // 최고 점수 업데이트
          });
        } else {
          print('Failed to load high score: highScoreData is null or does not contain maxScore');
        }
      } else {
        print('Failed to load high score');
      }


      // 게임 설명 가져오기
      final gameInfoResponse = await http.get(Uri.parse(gameInfoUrl));
      if (gameInfoResponse.statusCode == 200) {
        final gameInfoData = json.decode(gameInfoResponse.body);
        print('Game info data: $gameInfoData'); // 서버 응답 확인
        if (gameInfoData['result'] != null && gameInfoData['result'].isNotEmpty) {
          // 각 gameId에 따라 적절한 게임 설명을 가져오기
          switch (gameId) {
            case '1':
            case '668c2506bfaa70b1e661ce42': // 1번 게임 ID 또는 두더지 게임 ID
              final game = gameInfoData['result'].firstWhere((game) => game['gameId'] == '1', orElse: () => null);
              if (game != null) {
                setState(() {
                  gameRules = game['rules']; // 게임 설명 업데이트
                });
              } else {
                print('Failed to load game info: game not found');
              }
              break;
            case '2':
              final game = gameInfoData['result'].firstWhere((game) => game['gameId'] == '2', orElse: () => null);
              if (game != null) {
                setState(() {
                  gameRules = game['rules']; // 게임 설명 업데이트
                });
              } else {
                print('Failed to load game info: game not found');
              }
              break;
            case '3':
              final game = gameInfoData['result'].firstWhere((game) => game['gameId'] == '3', orElse: () => null);
              if (game != null) {
                setState(() {
                  gameRules = game['rules']; // 게임 설명 업데이트
                });
              } else {
                print('Failed to load game info: game not found');
              }
              break;
            case '4':
              final game = gameInfoData['result'].firstWhere((game) => game['gameId'] == '4', orElse: () => null);
              if (game != null) {
                setState(() {
                  gameRules = game['rules']; // 게임 설명 업데이트
                });
              } else {
                print('Failed to load game info: game not found');
              }
              break;
            default:
              print('Game ID does not match any known games');
          }
        } else {
          print('Failed to load game info: result is empty or null');
        }
      } else {
        print('Failed to load game info');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // 게임을 시작하는 함수
  Future<void> _startGame(BuildContext context) async {
    Widget screen; // 이동할 화면 변수 선언
    switch (widget.gameId) {
      case '1': // 게임 ID가 '1'이면 두더지 게임 화면으로 이동
      case '668c2506bfaa70b1e661ce42': // 게임 ID가 '668c2506bfaa70b1e661ce15'이면 두더지 게임 화면으로 이동
        screen = DudeojiGameScreen(title: widget.title);
        break;
      case '2': // 다른 게임 ID 예시
        screen = ImageGameScreen(title: widget.title);
        break;
      // 다른 gameId에 맞는 화면 추가
      default:
        screen = const Scaffold(
          body: Center(child: Text('Game not found')),
        );
        break;
    }

    // SharedPreferences에 게임 정보 저장
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', '668e1d4ce7359531484f8731'); // 실제 사용자 ID로 변경
    await prefs.setString('gameId', '668c2506bfaa70b1e661ce42'); // 게임 ID 저장
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen), // 해당 게임 화면으로 이동
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // 앱 바에 게임 제목 표시
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    myHighScore.toString(), // 최고 점수 표시
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '나의 최고 점수', // "나의 최고 점수" 텍스트
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  gameRules, // 게임 설명 표시
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                onTap: () => _startGame(context), // 시작하기 버튼을 눌렀을 때 _startGame 함수 호출
                text: '시작하기',
              ),
            ],
          ),
        ),
      ),
    );
    
  }
}
   
// import 'package:client/common/widgets/custom_elevated_button.dart';
// import 'package:client/ui/view/game/dudeoji_game_screen.dart';
// import 'package:client/ui/view/game/image_game_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class GameWaitScreen extends StatefulWidget {
//   static const routeName = '/game-wait';
//   final String title;
//   final String gameId;

//   const GameWaitScreen({
//     super.key,
//     required this.title,
//     required this.gameId,
//   });

//   @override
//   _GameWaitScreenState createState() => _GameWaitScreenState();
// }

// class _GameWaitScreenState extends State<GameWaitScreen> {
//   int myHighScore = 0; // 초기 최고 점수는 0으로 설정, 서버에서 가져올 예정
//   String gameRules = '게임 설명을 불러오는 중입니다...'; // 기본 게임 설명

//   @override
//   void initState() {
//     super.initState();
//     fetchHighScoreAndRules(); // 화면이 처음 생성될 때 최고 점수와 게임 설명을 가져오는 함수 호출
//   }

//   // 최고 점수와 게임 설명을 서버에서 가져오는 함수
//   Future<void> fetchHighScoreAndRules() async {
//     const userId = '668be5021e30fc472762bff2'; // 고정 사용자 ID
//     final gameId = widget.gameId; // 위젯에서 전달받은 게임 ID

//     // 실제 API 엔드포인트로 교체해야 함
//     final highScoreUrl = 'http://143.248.191.30:3000/score/max-score/$userId/$gameId';
//     const gameInfoUrl = 'http://143.248.191.30:3000/games';

//     try {
//       // 최고 점수 가져오기
//       final highScoreResponse = await http.get(Uri.parse(highScoreUrl));
//       if (highScoreResponse.statusCode == 200) {
//         final highScoreData = json.decode(highScoreResponse.body);
//         print('High score data: $highScoreData'); // 서버 응답 확인
//         if (highScoreData.containsKey('maxScore')) {
//           setState(() {
//             myHighScore = highScoreData['maxScore']; // 최고 점수 업데이트
//           });
//         } else {
//           print('Failed to load high score: highScoreData is null or does not contain maxScore');
//         }
//       } else {
//         print('Failed to load high score');
//       }

//       // 게임 설명 가져오기
//       final gameInfoResponse = await http.get(Uri.parse(gameInfoUrl));
//       if (gameInfoResponse.statusCode == 200) {
//         final gameInfoData = json.decode(gameInfoResponse.body);
//         print('Game info data: $gameInfoData'); // 서버 응답 확인
//         if (gameInfoData['result'] != null && gameInfoData['result'].isNotEmpty) {
//           // gameId가 '668c2506bfaa70b1e661ce12'와 일치하는 게임을 찾기
//           if (gameId == '1') {
//             final game = gameInfoData['result'].firstWhere((game) => game['gameId'] == '1', orElse: () => null);
//             if (game != null) {
//               setState(() {
//                 gameRules = game['rules']; // 게임 설명 업데이트
//               });
//             } else {
//               print('Failed to load game info: game not found');
//             }
//           } else {
//             print('Game ID does not match');
//           }
//         } else {
//           print('Failed to load game info: result is empty or null');
//         }
//       } else {
//         print('Failed to load game info');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   // 게임을 시작하는 함수
//   Future<void> _startGame(BuildContext context) async {
//     Widget screen; // 이동할 화면 변수 선언
//     switch (widget.gameId) {
//       case '1': // 게임 ID가 '1'이면 두더지 게임 화면으로 이동
//         screen = DudeojiGameScreen(title: widget.title);
//         break;
//       case '2': // 다른 게임 ID 예시
//         screen = ImageGameScreen(title: widget.title);
//         break;
//       // 다른 gameId에 맞는 화면 추가
//       default:
//         screen = const Scaffold(
//           body: Center(child: Text('Game not found')),
//         );
//         break;
//     }

//     // SharedPreferences에 게임 정보 저장
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userId', '668be5021e30fc472762bff2'); // 실제 사용자 ID로 변경
//     await prefs.setString('gameId', widget.gameId); // 게임 ID 저장
//     await prefs.setString('date', DateTime.now().toIso8601String()); // 현재 날짜 저장

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => screen), // 해당 게임 화면으로 이동
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title), // 앱 바에 게임 제목 표시
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     myHighScore.toString(), // 최고 점수 표시
//                     style: const TextStyle(
//                       fontSize: 60,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const Text(
//                     '나의 최고 점수', // "나의 최고 점수" 텍스트
//                     style: TextStyle(fontSize: 24),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 26.0),
//                 child: Text(
//                   gameRules, // 게임 설명 표시
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w100,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(height: 60),
//               CustomButton(
//                 onTap: () => _startGame(context), // 시작하기 버튼을 눌렀을 때 _startGame 함수 호출
//                 text: '시작하기',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }