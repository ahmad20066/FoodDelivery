
import 'package:flutter/cupertino.dart';
import 'package:order_app/helpers/usershelper.dart';
import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/models/usermodels.dart';

class AddressProvider with ChangeNotifier {
  late Future<UserModel?> currentUser;
  late UserModel? currentUser2;
  late Future<Address?> Function(String) findAddress;
  void update(Future<UserModel?> function) {
    currentUser = function;
    findAddress = (String id) async {
      currentUser2 = await currentUser;
      if (currentUser2!.adresses != null) {
        return currentUser2!.adresses!
            .firstWhere((element) => element.id == id);
      }
      return null;
    };
  }

  Future<void> addAddress(String userId, String city, String street,
      String building, String floor) async {
    Address addedAddress = Address(
        id: DateTime.now().toString(),
        city: city,
        street: street,
        buildingNumber: building,
        floor: floor);
    await UsersHelper.addAddress(userId, addedAddress);
  }

  Future<void> replace(String userId, Address editedAddress) async {
    final address = await findAddress(editedAddress.id);
    await UsersHelper.deleteAddress(userId, address!);
    editedAddress = Address(
        id: DateTime.now().toString(),
        city: editedAddress.city,
        street: editedAddress.street,
        buildingNumber: editedAddress.buildingNumber,
        floor: editedAddress.floor);
    currentUser2!.adresses!.add(editedAddress);
    await addAddress(userId, editedAddress.city, editedAddress.street,
        editedAddress.buildingNumber, editedAddress.floor);
  }
}
