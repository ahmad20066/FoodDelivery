import 'package:flutter/material.dart';
import 'package:order_app/models/cartitem.dart';
import 'package:order_app/providers/cartprovider.dart';

import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  String title;
  double price;
  int quantity;
  String id;
  final cartItems;
  CartWidget(this.title, this.price, this.quantity, this.id, this.cartItems);

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    Map<String, CartModel> cartItems = Provider.of<CartProvider>(context).items;
    return Column(
      children: [
        ListTile(
          leading: IconButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .delete(widget.id);
                if (cartItems.length == 1) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.delete, color: Colors.orange)),
          title: Text("${widget.title}  x${widget.quantity}"),
          trailing: Text("${widget.price * widget.quantity}\$"),
        ),
      ],
    );
  }
}
