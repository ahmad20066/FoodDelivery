import 'package:json_annotation/json_annotation.dart';
part 'meals.g.dart';

@JsonSerializable()
class Meal {
  String id;
  String name;
  String? description;
  dynamic image;
  String? url;
  double price;

  Meal({
    required this.id,
    required this.name,
    this.image,
    this.description,
    this.url,
    required this.price,
  });
  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
  Map<String, dynamic> toJson() => _$MealToJson(this);
}
