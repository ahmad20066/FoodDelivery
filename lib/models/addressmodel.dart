import 'package:json_annotation/json_annotation.dart';
part 'addressmodel.g.dart';

@JsonSerializable()
class Address {
  String id;
  String city;
  String street;
  String buildingNumber;
  String floor;

  Address({
    required this.id,
    required this.city,
    required this.street,
    required this.buildingNumber,
    required this.floor,
  });
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson([String? url]) => _$AddressToJson(this);
}
