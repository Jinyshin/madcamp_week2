import 'package:client/common/widgets/ranking_list_item.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  static String routeName = '/ranking-list';
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  // TODO: get game list from server
  final List<String> games = ['두더지 팡팡', '닮은 사람 찾기', '라이어 게임', '훈민정음'];
  String selectedGame = '두더지 팡팡';

  // TODO: get game ranking list from server
  final Map<String, List<Map<String, dynamic>>> gameRankings = {
    '두더지 팡팡': [
      {'title': '신진영', 'rank': 1, 'score': 100},
      {'title': '지녕', 'rank': 2, 'score': 90},
      {'title': '지니신', 'rank': 3, 'score': 80},
    ],
    '닮은 사람 찾기': [
      {'title': '유하', 'rank': 1, 'score': 95},
      {'title': '유하하하', 'rank': 2, 'score': 85},
      {'title': '유하핫', 'rank': 3, 'score': 75},
    ],
    '라이어 게임': [
      {'title': '규', 'rank': 1, 'score': 98},
      {'title': '큐큐', 'rank': 2, 'score': 88},
      {'title': '규찬이', 'rank': 3, 'score': 78},
    ],
    '훈민정음': [
      {'title': '민굥', 'rank': 1, 'score': 98},
      {'title': '민규', 'rank': 2, 'score': 88},
      {'title': '세혁', 'rank': 3, 'score': 78},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> rankings =
        gameRankings[selectedGame] ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('랭킹 보기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedGame,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGame = newValue!;
                });
              },
              items: games.map<DropdownMenuItem<String>>((String game) {
                return DropdownMenuItem<String>(
                  value: game,
                  child: Text(game),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: rankings.length,
                itemBuilder: (context, index) {
                  final ranking = rankings[index];
                  return RankingListItem(
                    title: ranking['title'],
                    rank: ranking['rank'],
                    score: ranking['score'],
                    onTap: () {
                      // Add your onTap logic here
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
