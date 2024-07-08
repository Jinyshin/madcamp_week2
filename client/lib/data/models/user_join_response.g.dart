// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_join_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJoinResponse _$UserJoinResponseFromJson(Map<String, dynamic> json) =>
    UserJoinResponse(
      isSuccess: json['isSuccess'] as bool,
      code: (json['code'] as num).toInt(),
      message: json['message'] as String,
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserJoinResponseToJson(UserJoinResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as String,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
    };
