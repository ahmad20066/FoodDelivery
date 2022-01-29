import 'package:order_app/models/addressmodel.dart';
import 'package:json_annotation/json_annotation.dart';
part 'usermodels.g.dart';

@JsonSerializable()
class UserModel {
  String userId;
  String username;
  String email;
  String? location;
  List<Address>? adresses;
  String number;
  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    this.location,
    this.adresses,
    required this.number,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson([String? url]) => _$UserModelToJson(this);
}
