// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserJoinRequest _$UserJoinRequestFromJson(Map<String, dynamic> json) =>
    UserJoinRequest(
      json['displayName'] as String,
      json['email'] as String,
      json['id'] as String,
      json['photoUrl'] as String,
    );

Map<String, dynamic> _$UserJoinRequestToJson(UserJoinRequest instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'id': instance.id,
      'photoUrl': instance.photoUrl,
    };
