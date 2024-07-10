import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:client/common/const/app_colors.dart';
import 'package:client/ui/view/game_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DudeojiGameScreen extends StatefulWidget {
  static const routeName = '/dudeoji-game';
  final String title;
  const DudeojiGameScreen({super.key, required this.title});

  @override
  State<DudeojiGameScreen> createState() => _DudeojiGameScreenState();
}

class _DudeojiGameScreenState extends State<DudeojiGameScreen> {
  final int rows = 3;
  final int columns = 4;
  final int gameTime = 20;
  List<bool> moles = [];
  int score = 0;
  late Timer _timer;
  int _timeRemaining = 20;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    score = 0;
    moles = List.filled(rows * columns, false);
    _timeRemaining = gameTime;
    progress = 0.0;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining <= 0) {
        timer.cancel();
      } else if (mounted) {
        setState(() {
          final random = Random();
          final index = random.nextInt(rows * columns);
          moles[index] = !moles[index];
          if (moles[index]) {
            Timer(const Duration(milliseconds: 500), () {
              if (mounted) {
                setState(() {
                  moles[index] = false;
                });
              }
            });
          }
        });
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeRemaining--;
        progress = 1 - (_timeRemaining / gameTime);
      });
      if (_timeRemaining <= 0) {
        timer.cancel();
        endGame();
      }
    });
  }

  void endGame() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';
    final gameId = prefs.getString('gameId') ?? '';

    print("---");
    print(userId);
    print(gameId);
    print("---");

    // 서버에 점수 저장 요청
    await postScore(userId, gameId, score);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('게임 종료'),
          content: Text('점수: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                  GameListScreen.routeName,
                  (Route<dynamic> route) => false,
                )
                    .then((_) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const DudeojiGameScreen(title: '두더지 잡기'),
                  ));
                });
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  Future<void> postScore(String userId, String gameId, int score) async {
    final url =
        Uri.parse('http://143.248.191.30:3000/score'); // 실제 서버 URL로 변경 필요
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'userId': userId,
      'gameId': gameId,
      'score': score,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Score posted successfully');
    } else {
      print('Failed to post score: ${response.body}');
    }
  }

  void onTapMole(int index) {
    if (moles[index]) {
      setState(() {
        moles[index] = false;
        score++;
      });
    }
  }

  List<Widget> buildGridItems() {
    List<Widget> items = [];
    for (int i = 0; i < rows * columns; i++) {
      items.add(
        GestureDetector(
          onTap: () => onTapMole(i),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('asset/land.png')),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: moles[i]
                    ? Image.asset(
                        'asset/mole.png',
                        height: 80,
                        width: 80,
                      )
                    : null,
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Whack a Mole',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              backgroundColor: Colors.orange,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.orange,
                width: 4,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Text(
              'Score: $score',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: buildGridItems(),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0), // 좌우 패딩 추가
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: progress),
              duration:
                  const Duration(seconds: 1), // 부드러운 진행을 위해 애니메이션 지속 시간 조절
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * value,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Center(
                      child: Text(
                        '00:${_timeRemaining.toString().padLeft(2, '0')}',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// 앱의 진입점
void main() {
  runApp(const MyApp());
}

// 메인 앱 클래스
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whack a Mole Game',
      debugShowCheckedModeBanner: false,
      home: DudeojiGameScreen(title: 'Whack a Mole'),
      routes: {
        GameListScreen.routeName: (context) => const GameListScreen(), // 경로 설정
      },
    );
  }
}
// import 'dart:async';
// import 'dart:math';
// import 'package:client/common/const/app_colors.dart';
// import 'package:client/ui/view/game_list_screen.dart';
// import 'package:flutter/material.dart';

// class DudeojiGameScreen extends StatefulWidget {
//   final String title;
//   const DudeojiGameScreen({super.key, required this.title});

//   @override
//   State<DudeojiGameScreen> createState() => _DudeojiGameScreenState();
// }

// class _DudeojiGameScreenState extends State<DudeojiGameScreen> {
//   final int rows = 3;
//   final int columns = 4;
//   final int gameTime = 20;
//   List<bool> moles = [];
//   int score = 0;
//   late Timer _timer;
//   int _timeRemaining = 20;
//   double progress = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     startGame();
//   }

//   void startGame() {
//     score = 0;
//     moles = List.filled(rows * columns, false);
//     _timeRemaining = gameTime;
//     progress = 0.0;

//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_timeRemaining <= 0) {
//         timer.cancel();
//       } else if (mounted) {
//         setState(() {
//           final random = Random();
//           final index = random.nextInt(rows * columns);
//           moles[index] = !moles[index];
//           if (moles[index]) {
//             Timer(const Duration(milliseconds: 500), () {
//               if (mounted) {
//                 setState(() {
//                   moles[index] = false;
//                 });
//               }
//             });
//           }
//         });
//       }
//     });

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         _timeRemaining--;
//         progress = 1 - (_timeRemaining / gameTime);
//       });
//       if (_timeRemaining <= 0) {
//         timer.cancel();
//         endGame();
//       }
//     });
//   }

//   void endGame() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('게임 종료'),
//           content: Text('점수: $score'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                   GameListScreen.routeName,
//                   (Route<dynamic> route) => false,
//                 ).then((_) {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const DudeojiGameScreen(title: '두더지 잡기'),
//                   ));
//                 });
//               },
//               child: Text('확인'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void onTapMole(int index) {
//     if (moles[index]) {
//       setState(() {
//         moles[index] = false;
//         score++;
//       });
//     }
//   }

//   List<Widget> buildGridItems() {
//     List<Widget> items = [];
//     for (int i = 0; i < rows * columns; i++) {
//       items.add(
//         GestureDetector(
//           onTap: () => onTapMole(i),
//           child: Container(
//             margin: const EdgeInsets.all(4),
//             decoration: const BoxDecoration(
//               image: DecorationImage(image: AssetImage('asset/land.png')),
//             ),
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 32),
//                 child: moles[i]
//                     ? Image.asset(
//                         'asset/mole.png',
//                         height: 80,
//                         width: 80,
//                       )
//                     : null,
//               ),
//             ),
//           ),
//         ),
//       );
//     }
//     return items;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Text(
//             'Whack a Mole',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 40,
//               backgroundColor: Colors.orange,
//             ),
//           ),
//           const SizedBox(height: 40),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.orange,
//                 width: 4,
//               ),
//               borderRadius: const BorderRadius.all(Radius.circular(20)),
//             ),
//             child: Text(
//               'Score: $score',
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: columns,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: buildGridItems(),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: TweenAnimationBuilder(
//               tween: Tween<double>(begin: 0, end: progress),
//               duration: const Duration(seconds: 1), // 부드러운 진행을 위해 애니메이션 지속 시간 조절
//               builder: (context, value, child) {
//                 return Stack(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width * value,
//                       height: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     Center(
//                       child: Text(
//                         '00:${_timeRemaining.toString().padLeft(2, '0')}',
//                         style: TextStyle(color: Colors.black, fontSize: 20),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

// // 앱의 진입점
// void main() {
//   runApp(const MyApp());
// }

// // 메인 앱 클래스
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Whack a Mole Game',
//       debugShowCheckedModeBanner: false,
//       home: DudeojiGameScreen(title: 'Whack a Mole'),
//     );
//   }
// }