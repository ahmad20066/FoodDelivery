// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      deliveryFee: json['deliveryFee'] as int,
      meals: (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
      logoUrl: json['logoUrl'] as String?,
      isOnline: json['isOnline'] as bool?,
      location: json['location'] as String,
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deliveryFee': instance.deliveryFee,
      'meals': instance.meals.map((e) => e.toJson()).toList(),
      'url': instance.url,
      'logoUrl': instance.logoUrl,
      'location': instance.location,
      'isOnline': instance.isOnline,
    };
