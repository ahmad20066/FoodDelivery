// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usermodels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: json['userId'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      location: json['location'] as String?,
      adresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: json['number'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'location': instance.location,
      'addresses': instance.adresses != null
          ? instance.adresses!.map((e) => e.toJson()).toList()
          : null,
      'number': instance.number.toString(),
    };
