import 'package:flutter/material.dart';

import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/providers/addressprovider.dart';
import 'package:order_app/providers/authprovider.dart';

import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  static const routename = '/address';
  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;

  Address editedAddress =
      Address(id: '', city: '', street: '', buildingNumber: '', floor: '');
  final _form = GlobalKey<FormState>();
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      final addressId = ModalRoute.of(context)!.settings.arguments as String;

      if (addressId != null) {
        setState(() {
          isLoading = true;
        });

        Provider.of<AddressProvider>(context, listen: false)
            .findAddress(addressId)
            .then((value) {
          editedAddress = value!;

          setState(() {
            isLoading = false;
          });
        });
      }
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<AuthProvider>(context).currentUserId!;
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: ListView(
                children: [
                  TextFormField(
                    initialValue: editedAddress.city,
                    decoration: const InputDecoration(
                        label: Text("City"), icon: Icon(Icons.location_city)),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter a city";
                      }
                    },
                    onSaved: (city) {
                      editedAddress = Address(
                          id: editedAddress.id,
                          city: city ?? '',
                          street: editedAddress.street,
                          buildingNumber: editedAddress.buildingNumber,
                          floor: editedAddress.floor);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Street"), icon: Icon(Icons.streetview)),
                    initialValue: editedAddress.street,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter a Street";
                      }
                    },
                    onSaved: (street) {
                      editedAddress = Address(
                          id: editedAddress.id,
                          city: editedAddress.city,
                          street: street ?? '',
                          buildingNumber: editedAddress.buildingNumber,
                          floor: editedAddress.floor);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Building"), icon: Icon(Icons.house)),
                    initialValue: editedAddress.buildingNumber,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter your building info";
                      }
                    },
                    onSaved: (building) {
                      editedAddress = Address(
                          id: editedAddress.id,
                          city: editedAddress.city,
                          street: editedAddress.street,
                          buildingNumber: building ?? '',
                          floor: editedAddress.floor);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Floor"),
                        icon: Icon(Icons.format_list_numbered)),
                    initialValue: editedAddress.floor,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null) {
                        return "Please Enter your floor info";
                      }
                    },
                    onSaved: (floor) {
                      editedAddress = Address(
                          id: editedAddress.id,
                          city: editedAddress.city,
                          street: editedAddress.street,
                          buildingNumber: editedAddress.buildingNumber,
                          floor: floor ?? '');
                    },
                  ),
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        _form.currentState!.save();
                        editedAddress.id == ''
                            ? await Provider.of<AddressProvider>(context,
                                    listen: false)
                                .addAddress(
                                    userId,
                                    editedAddress.city,
                                    editedAddress.street,
                                    editedAddress.buildingNumber,
                                    editedAddress.floor)
                            : await Provider.of<AddressProvider>(context,
                                    listen: false)
                                .replace(userId, editedAddress);
                        isLoading = false;
                        Navigator.of(context).pop();
                      },
                      child: const Text("Add Address")),
                ],
              ),
            ),
    );
  }
}
