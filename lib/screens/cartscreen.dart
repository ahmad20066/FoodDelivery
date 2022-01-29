import 'package:flutter/material.dart';
import 'package:order_app/providers/cartprovider.dart';

import 'package:order_app/screens/checkoutscreen.dart';

import 'package:order_app/widgets/cartwidget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routename = '/cartScreen';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).items;
    double total = Provider.of<CartProvider>(context).getTotal();
    final restaurantId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: TextButton.icon(
              onPressed: () async {
                setState(() {
                  isloading = true;
                });
                Navigator.of(context).pushNamed(CheckOutScreen.routename,
                    arguments: restaurantId);
                setState(() {
                  isloading = false;
                });
              },
              icon: const Icon(Icons.shopping_cart),
              label: const Text("Proceed to checkout")),
        ),
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          return CartWidget(
                              cartItems.values.toList()[index].title,
                              cartItems.values.toList()[index].price,
                              cartItems.values.toList()[index].quantity,
                              cartItems.values.toList()[index].id,
                              cartItems);
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Total amount : ",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "$total\$",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
  }
}
