import 'package:flutter/material.dart'; // 플러터 UI 패키지 임포트
import 'package:http/http.dart' as http; // HTTP 요청을 위한 패키지 임포트
import 'dart:convert'; // JSON 처리를 위한 패키지 임포트

class RankingScreen extends StatefulWidget {
  // 랭킹 화면 위젯 클래스 정의
  static String routeName = '/ranking-list'; // 라우트 이름 정의
  const RankingScreen({super.key}); // 생성자 정의

  @override
  State<RankingScreen> createState() => _RankingScreenState(); // 상태 클래스 생성
}

class _RankingScreenState extends State<RankingScreen> {
  final List<String> games = [
    '두더지 팡팡',
    '닮은 사람 찾기',
    '라이어 게임',
    '훈민정음'
  ]; // 게임 목록 정의
  String selectedGame = '두더지 팡팡'; // 기본 선택된 게임 정의
  Map<String, List<Map<String, dynamic>>> gameRankings =
      {}; // 게임 랭킹 데이터 저장을 위한 맵 정의

  @override
  void initState() {
    super.initState(); // 부모 클래스의 initState 호출
    print('initState 호출');
    fetchRankings(); // 랭킹 데이터를 가져오는 함수 호출
  }

  Future<void> fetchRankings() async {
    // 랭킹 데이터를 가져오는 비동기 함수 정의
    final gameIdMap = {
      '두더지 팡팡': '668c2506bfaa70b1e661ce42',
      '닮은 사람 찾기': '668c2506bfaa70b1e661ce45',
      '라이어 게임': '668c2507bfaa70b1e661ce48',
      '훈민정음': '668c2507bfaa70b1e661ce4b',
    }; // 각 게임의 ID를 매핑한 맵 정의
    print('게임 ID 맵: $gameIdMap');

    for (String game in games) {
      print('현재 게임: $game');
      final gameId = gameIdMap[game] ?? ''; // 현재 게임의 ID 가져오기
      print('현재 게임 ID: $gameId');
      
      final url = Uri.parse(
          'http://143.248.191.30:3000/score/rank/$gameId'); // API URL 생성
      print('URL 생성: $url');
      final response = await http.get(url); // GET 요청 보내기
      print('HTTP GET 요청 보냄');

      if (response.statusCode == 200) {
        // 응답이 성공적일 때
        print('응답 성공: ${response.body}'); // 응답 내용 출력
        final List<dynamic> jsonResponse =
            json.decode(response.body); // JSON 파싱
        print('JSON 파싱 완료: $jsonResponse');

        // userId가 null이 아닌 데이터만 필터링
        final List<Map<String, dynamic>> rankings = jsonResponse
            .where((data) => data['userId'] != null)
            .map<Map<String, dynamic>>((data) => {
                  'title': data['userId']['displayName'],
                  'rank': 0, // 랭킹은 정렬 후 결정됩니다.
                  'score': data['score']
                })
            .toList(); // 랭킹 데이터 가공
        print('랭킹 데이터 가공 완료: $rankings');

        // 상위 3개의 랭킹만 저장
        setState(() {
          // 상태 업데이트
          gameRankings[game] = rankings.take(3).toList();
          print("업데이트된 게임 랭킹 for $game: ${gameRankings[game]}");
        });
      } else {
        print(
            '게임 랭킹 로드 실패 for $game, 응답 내용: ${response.body}'); // 실패 시 오류 메시지 출력
      }
    }
    print("최종 게임 랭킹: $gameRankings");
  }

  @override
  Widget build(BuildContext context) {
    print('build 호출');
    final List<Map<String, dynamic>> rankings =
        gameRankings[selectedGame] ?? []; // 선택된 게임의 랭킹 데이터 가져오기
    print('선택된 게임 랭킹: $rankings');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // 뒤로 가기 버튼 아이콘
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기 버튼 클릭 시 이전 화면으로 돌아가기
          },
        ),
        title: const Text('랭킹 보기'), // 앱바 제목 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 전체 패딩 설정
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedGame, // 드롭다운 버튼의 현재 선택된 값
              onChanged: (String? newValue) {
                setState(() {
                  selectedGame = newValue!; // 선택된 값 변경
                  print('선택된 게임 변경: $selectedGame');
                });
              },
              items: games.map<DropdownMenuItem<String>>((String game) {
                return DropdownMenuItem<String>(
                  value: game,
                  child: Text(game), // 드롭다운 메뉴 아이템 텍스트 설정
                );
              }).toList(), // 드롭다운 메뉴 아이템 리스트
            ),
            const SizedBox(height: 20), // 간격 추가
            Expanded(
              child: ListView.builder(
                itemCount: rankings.length, // 랭킹 리스트 아이템 개수
                itemBuilder: (context, index) {
                  final ranking = rankings[index]; // 현재 아이템 데이터 가져오기
                  print('현재 아이템 데이터: $ranking');
                  return ListTile(
                    title: Text(ranking['title']), // 사용자 이름 표시
                    subtitle: Text('Score: ${ranking['score']}'), // 점수 표시
                    leading: CircleAvatar(
                      child: Text((index + 1).toString()), // 순위 표시
                    ),
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