import 'package:flutter/material.dart';
import 'package:order_app/providers/cartprovider.dart';
import 'package:order_app/providers/restaurant_provider.dart';

import 'package:provider/provider.dart';

class MealDetailsScreen extends StatefulWidget {
  static const routename = '/mealDetails';

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late final _future;
  late final arguments;
  late final mealID;
  late final mealRestaurant;
  late final meal;
  bool isInit = true;
  int count = 1;

  @override
  void didChangeDependencies() {
    if (isInit) {
      arguments = ModalRoute.of(context)!.settings.arguments as Map;
      mealID = arguments['id'];
      mealRestaurant = arguments['restaurant'];
      meal = Provider.of<RestaurantProvider>(context, listen: false)
          .findMealByID(mealID, mealRestaurant);
      _future = Provider.of<RestaurantProvider>(context, listen: false)
          .loadImage("${mealRestaurant.name}/${meal.name}/${meal.id}.jpg");
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Stack(children: [
              FutureBuilder<Image>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: 400,
                        height: 200,
                        child: snapshot.requireData,
                      ),
                    );
                  }),
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.orangeAccent,
                      )),
                ),
              )
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  meal.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  "${meal.price}\$",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: meal.description == null
                  ? Text(
                      "No Description available",
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : Text(meal.description!,
                      style: Theme.of(context).textTheme.headline6),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              color: Colors.white24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () {
                        if (count > 1) {
                          setState(() {
                            count--;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.orange,
                      )),
                  Text(
                    "$count",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        count++;
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton.icon(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addCartItem(mealID, meal.name, meal.price, count);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Add to cart")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
