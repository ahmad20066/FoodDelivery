import 'package:flutter/cupertino.dart';

import 'package:order_app/models/meals.dart';

class MealsProvider with ChangeNotifier {
  final List<Meal> _meals = [];
  List<Meal> get meals {
    return [..._meals];
  }
}
