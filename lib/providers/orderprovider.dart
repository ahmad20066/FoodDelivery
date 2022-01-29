import 'package:flutter/cupertino.dart';
import 'package:order_app/helpers/ordershelper.dart';
import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/models/cartitem.dart';
import 'package:order_app/models/ordermodel.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];
  List<OrderModel> get orders {
    return [..._orders];
  }

  late String? userId;
  void update(String? userID) {
    if (userID == null) {
      userId = null;
    } else {
      userId = userID;
    }
  }

  Future<void> addOrder(String restaurantId, DateTime date, double amount,
      List<CartModel> items, Address address) async {
    final addedOrder = OrderModel(
        restaurantID: restaurantId,
        id: DateTime.now().toString(),
        date: date,
        amount: amount,
        items: items,
        userID: userId!,
        address: address);

    await OrderHelper.addOrder(addedOrder);
    _orders.add(addedOrder);
    notifyListeners();
  }

  Future<void> getOrders() async {
    final List<OrderModel> fetchedOrders = [];
    final docs = await OrderHelper.getOrders(userId!);
    for (var element in docs) {
      fetchedOrders.add(element.data()!);
    }
    _orders = fetchedOrders;

    notifyListeners();
  }
}
