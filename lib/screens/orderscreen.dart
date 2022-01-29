import 'package:flutter/material.dart';

import 'package:order_app/providers/orderprovider.dart';
import 'package:order_app/providers/restaurant_provider.dart';
import 'package:order_app/widgets/orderwidget.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routename = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future future;
  @override
  void initState() {
    future = Provider.of<OrderProvider>(context, listen: false).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;

    return Scaffold(
        appBar: AppBar(
          title: const Text("orders"),
        ),
        body: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final restaurant = Provider.of<RestaurantProvider>(
                                context,
                                listen: false)
                            .findRestaurantByID(orders[index].restaurantID);
                        return OrderWidget(restaurant.name,
                            orders[index].amount, orders[index].items);
                      }),
                );
              }
            }));
  }
}
