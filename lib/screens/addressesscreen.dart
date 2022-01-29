import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_app/helpers/usershelper.dart';
import 'package:order_app/models/usermodels.dart';
import 'package:order_app/providers/authprovider.dart';
import 'package:order_app/screens/addressadd.dart';
import 'package:order_app/widgets/addresswidget.dart';

import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class AddressesScreen extends StatefulWidget {
  static const routename = '/addressesScreen';
  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  late Future<UserModel?> _future;
  bool isInit = true;
  late AsyncSnapshot<UserModel?> _snapshot;
  late final Stream<DocumentSnapshot<UserModel>> _stream =
      UsersHelper.getStream(_snapshot.data!.userId);

  @override
  void initState() {
    _future =
        Provider.of<AuthProvider>(this.context, listen: false).currentUser;
    print("Aaaa");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TextButton.icon(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddAddressScreen.routename);
            },
            label: const Text("Add an address")),
      ),
      appBar: AppBar(
        title: const Text("Your addresses"),
      ),
      body: FutureBuilder<UserModel?>(
          future: _future,
          builder: (context, snapshot) {
            _snapshot = snapshot;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.adresses != null) {
              return StreamBuilder<DocumentSnapshot<UserModel>>(
                  stream: _stream,
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    final userAddresses = streamSnapshot.data!.data()!.adresses;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: userAddresses!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                AddressWidget(
                                    userAddresses[index].id,
                                    userAddresses[index].city,
                                    userAddresses[index].street,
                                    userAddresses[index].buildingNumber,
                                    userAddresses[index].floor),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                )
                              ],
                            );
                          }),
                    );
                  });
            } else {
              return Center(
                child: Text(
                  "No Addresses Available",
                  style: Theme.of(context).textTheme.headline2,
                ),
              );
            }
          }),
    );
  }
}
