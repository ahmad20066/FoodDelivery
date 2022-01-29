import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:order_app/helpers/usershelper.dart';
import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/models/usermodels.dart';
import 'package:order_app/providers/authprovider.dart';
import 'package:order_app/providers/cartprovider.dart';
import 'package:order_app/providers/orderprovider.dart';
import 'package:order_app/screens/addressadd.dart';

import 'package:order_app/widgets/bottomsheet.dart';

import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  static const routename = '/checkout';
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  late Future<UserModel?> future;
  late AsyncSnapshot<UserModel?> _snapshot;
  late final Stream<DocumentSnapshot<UserModel>> _stream =
      UsersHelper.getStream(_snapshot.data!.userId);
  bool isLoading = false;
  @override
  void initState() {
    future = Provider.of<AuthProvider>(this.context, listen: false).currentUser;
    super.initState();
  }

  Address? currentAddress;
  void _changeCurrentAddress(Address Address) {
    currentAddress = Address;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double total = Provider.of<CartProvider>(context).getTotal();
    final cartItems = Provider.of<CartProvider>(context).items.values.toList();
    final restaurantID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: TextButton.icon(
            onPressed: () async {
              if (currentAddress == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text("Enter an Address"),
                  backgroundColor: Theme.of(context).errorColor,
                ));
              } else {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<OrderProvider>(context, listen: false)
                    .addOrder(restaurantID, DateTime.now(), total, cartItems,
                        currentAddress!);
                Provider.of<CartProvider>(context, listen: false).clear();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (Route<dynamic> route) => false,
                );
                setState(() {
                  isLoading = false;
                });
              }
            },
            icon: const Icon(Icons.shopping_cart),
            label: const Text("Order Now")),
      ),
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          FutureBuilder<UserModel?>(
            future: future,
            builder: (context, snapshot) {
              _snapshot = snapshot;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              List<Address>? addresses = snapshot.data!.adresses;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment(-0.9, -0.5),
                      child: Text(
                        "Address:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        currentAddress != null
                            ? "${currentAddress!.city}/${currentAddress!.street}"
                            : "No Address Selected",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      trailing: TextButton(
                        child: const Text(
                          "Change",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              AddAddressScreen.routename);
                                        },
                                        child: const Text("Add an address")),
                                    addresses != null
                                        ? StreamBuilder<
                                                DocumentSnapshot<UserModel>>(
                                            stream: _stream,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return CircularProgressIndicator();
                                              }

                                              return AddressesBottomSheet(
                                                  snapshot.data!
                                                      .data()!
                                                      .adresses!,
                                                  _changeCurrentAddress);
                                            })
                                        : const Expanded(
                                            child: Center(
                                              child: Text("No Adresses"),
                                            ),
                                          ),
                                  ],
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
