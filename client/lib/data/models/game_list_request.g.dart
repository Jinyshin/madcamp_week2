// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameListRequest _$GameListRequestFromJson(Map<String, dynamic> json) =>
    GameListRequest(
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      rules: json['rules'] as String,
    );

Map<String, dynamic> _$GameListRequestToJson(GameListRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameId': instance.gameId,
      'name': instance.name,
      'description': instance.description,
      'rules': instance.rules,
    };
