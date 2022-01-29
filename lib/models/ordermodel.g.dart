// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordermodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
    restaurantID: json['restaurantID'] as String,
    id: json['id'] as String,
    date: DateTime.parse(json['date'] as String),
    amount: (json['amount'] as num).toDouble(),
    items: (json['items'] as List<dynamic>)
        .map((e) => CartModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    userID: json['userId'],
    address: Address.fromJson(json));

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'restaurantID': instance.restaurantID,
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'amount': instance.amount,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'userId': instance.userID,
      'address': instance.address.toJson(),
    };
