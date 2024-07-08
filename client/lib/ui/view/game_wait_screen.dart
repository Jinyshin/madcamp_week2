import 'package:client/common/widgets/custom_elevated_button.dart';
import 'package:client/ui/view/game/dudeoji_game_screen.dart';
import 'package:client/ui/view/game/image_game_screen.dart';
import 'package:flutter/material.dart';

class GameWaitScreen extends StatelessWidget {
  static const routeName = '/game-wait';
  final String title;
  final String gameId;

  const GameWaitScreen({
    super.key,
    required this.title,
    required this.gameId,
  });

  void _startGame(BuildContext context) {
    Widget screen;
    switch (gameId) {
      case '1':
        screen = DudeojiGameScreen(title: title);
        break;
      case '2':
        screen = ImageGameScreen(title: title);
        break;
      // 다른 gameId에 맞는 화면 추가
      default:
        screen = const Scaffold(
          body: Center(child: Text('Game not found')),
        );
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: These values should be fetched from the server
    const String gameRules = '두더지 게임은 화면에 나타나는 두더지를 잡는 게임입니다. 폭탄은 터치하지 마세요.';
    const int myHighScore = 22; // Initially 2, will be fetched from the server

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                    myHighScore.toString(),
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    '나의 최고 점수',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 26.0),
                child: Text(
                  gameRules,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                onTap: () => _startGame(context),
                text: '시작하기',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
