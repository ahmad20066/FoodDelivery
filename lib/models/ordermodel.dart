import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/models/cartitem.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ordermodel.g.dart';

@JsonSerializable()
class OrderModel {
  final String restaurantID;
  final String id;
  final DateTime date;
  final double amount;
  List<CartModel> items;
  final String userID;
  final Address address;
  OrderModel(
      {required this.restaurantID,
      required this.id,
      required this.date,
      required this.amount,
      required this.items,
      required this.userID,
      required this.address});
  // OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
  //     restaurantID: ,
  //     id: json['id'],
  //     date: json['date'],
  //     amount: json['amount'],
  //     items: json['items']);
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  Map<String, dynamic> toJson([String? url]) => _$OrderModelToJson(this);
}
