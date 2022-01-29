import 'meals.dart';
import 'package:json_annotation/json_annotation.dart';
part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  String id;
  String name;
  dynamic image;
  dynamic logo;
  int deliveryFee;
  List<Meal> meals;
  String? url;
  String? logoUrl;
  String location;
  bool? isOnline = false;
  Restaurant(
      {required this.id,
      required this.name,
      this.image,
      this.logo,
      required this.deliveryFee,
      required this.meals,
      this.url,
      this.logoUrl,
      this.isOnline,
      required this.location});
  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);
  Map<String, dynamic> toJson([String? url]) => _$RestaurantToJson(this);
}
