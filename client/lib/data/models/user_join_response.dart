import 'package:json_annotation/json_annotation.dart';

part 'user_join_response.g.dart';

// 회원가입 응답을 위한 모델
@JsonSerializable()
class UserJoinResponse {
  final bool isSuccess;
  final int code;
  final String message;
  final Result result;

  UserJoinResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory UserJoinResponse.fromJson(Map<String, dynamic> json) =>
      _$UserJoinResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserJoinResponseToJson(this);
}

@JsonSerializable()
class Result {
  final String id;

  Result({required this.id});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
