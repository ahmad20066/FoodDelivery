import 'package:flutter/cupertino.dart';
import 'package:order_app/models/cartitem.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _items = {};
  Map<String, CartModel> get items {
    return {..._items};
  }

  void addCartItem(
    String ID,
    String title,
    double price,
    int count,
  ) {
    if (items.containsKey(ID)) {
      _items.update(
          ID,
          (value) => CartModel(
              id: ID,
              title: title,
              price: price,
              quantity: value.quantity + count));
      notifyListeners();
    } else {
      CartModel addedCartItem =
          CartModel(id: ID, title: title, price: price, quantity: count);
      _items.addAll({
        ID: addedCartItem,
      });
      notifyListeners();
    }
  }

  void delete(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  double getTotal() {
    double sum = 0;
    _items.forEach((key, value) {
      sum += (value.price * value.quantity);
    });
    return sum;
  }
}
