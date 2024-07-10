import 'package:json_annotation/json_annotation.dart';

part 'game_list_request.g.dart';

@JsonSerializable()
class GameListRequest {
  final String id;
  final String gameId;
  final String name;
  final String description;
  final String rules;

  GameListRequest({
    required this.id,
    required this.gameId,
    required this.name,
    required this.description,
    required this.rules,
  });

  
  factory GameListRequest.fromJson(Map<String, dynamic> json) {
    return GameListRequest(
      id: json['id'] ?? '', // 기본값 설정
      gameId: json['gameId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      rules: json['rules'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$GameListRequestToJson(this);
}