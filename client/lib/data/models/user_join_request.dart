import 'package:json_annotation/json_annotation.dart';

part 'user_join_request.g.dart';

// 회원가입 요청을 위한 모델
@JsonSerializable()
class UserJoinRequest {
  final String displayName;
  final String email;
  final String id;
  final String? photoUrl;

  UserJoinRequest(
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
  );

  factory UserJoinRequest.fromJson(Map<String, dynamic> json) =>
      _$UserJoinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserJoinRequestToJson(this);
}
