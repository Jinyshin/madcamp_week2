import 'dart:convert';
import 'package:client/common/widgets/game_list_tile.dart';
import 'package:client/data/models/game_list_request.dart';
import 'package:client/ui/view/game_wait_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'game_list_request.dart';

class GameListScreen extends StatefulWidget {
  static String routeName = '/game-list';
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  List<GameListRequest> games = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  Future<void> fetchGames() async {
    const url = 'http://143.248.191.30:3000/games';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['result'];
      setState(() {
        games = jsonResponse.map((data) => GameListRequest.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load games');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('게임 선택'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  return GameListTile(
                    title: games[index].name,
                    subtitle: games[index].description,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWaitScreen(
                            title: games[index].name,
                            gameId: games[index].gameId,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
// import 'package:client/common/widgets/game_list_tile.dart';
// import 'package:client/ui/view/game_wait_screen.dart';
// import 'package:flutter/material.dart';

// class GameListScreen extends StatefulWidget {
//   static String routeName = '/game-list';
//   const GameListScreen({super.key});

//   @override
//   State<GameListScreen> createState() => _GameListScreenState();
// }

// class _GameListScreenState extends State<GameListScreen> {
//   // TODO: Get data from Server
//   final List<Map<String, String>> games = [
//     {'title': '두더지 팡팡', 'subtitle': '최대한 빠르게 두더지를 때려봅시다!', 'id': '1'},
//     {'title': '닮은 사람 찾기', 'subtitle': '가장 닮은 사람 둘 마셔!', 'id': '2'},
//     {'title': '라이어 게임', 'subtitle': '누구인가.. 누가 라이어소리를 내었어...', 'id': '3'},
//     {'title': '훈민정음', 'subtitle': '한국어 좀 치는 분들 모이세요', 'id': '4'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: const Text('게임 선택'),
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(20),
//         child: ListView.builder(
//           itemCount: games.length,
//           itemBuilder: (context, index) {
//             return GameListTile(
//               title: games[index]['title']!,
//               subtitle: games[index]['subtitle']!,
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => GameWaitScreen(
//                       title: games[index]['title']!,
//                       gameId: games[index]['id']!,
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
