// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      buildingNumber: json['buildingNumber'] as String,
      floor: json['floor'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'street': instance.street,
      'buildingNumber': instance.buildingNumber,
      'floor': instance.floor,
    };
