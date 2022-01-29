import 'package:json_annotation/json_annotation.dart';
part 'cartitem.g.dart';

@JsonSerializable()
class CartModel {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson([String? url]) => _$CartModelToJson(this);
}
