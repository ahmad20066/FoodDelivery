import 'package:flutter/material.dart';
import 'package:order_app/providers/cartprovider.dart';
import 'package:order_app/providers/restaurant_provider.dart';
import 'package:order_app/screens/cartscreen.dart';
import 'package:order_app/widgets/meal_widget.dart';
import 'package:provider/provider.dart';
import 'package:sliver_header_delegate/sliver_header_delegate.dart';

class RestaurantDetialPage extends StatelessWidget {
  static const routename = '/details';
  const RestaurantDetialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String restauratnID =
        ModalRoute.of(context)!.settings.arguments as String;
    final restaurant = Provider.of<RestaurantProvider>(context)
        .findRestaurantByID(restauratnID);
    final cartItems = Provider.of<CartProvider>(context).items;
    return Scaffold(
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : BottomAppBar(
              child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routename,
                        arguments: restauratnID);
                    //print(cartItems[0]);
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("View your cart")),
            ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: FlexibleHeaderDelegate(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        if (cartItems.isNotEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Icon(
                                    Icons.warning,
                                    color: Colors.orange,
                                  ),
                                  content: Text(
                                    "You have items in your cart they will be cleared if you quit!",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .clear();
                                              Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/',
                                                (Route<dynamic> route) => false,
                                              );
                                            },
                                            child: const Text("Ok")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel")),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.orangeAccent,
                      )),
                ),
              ),
              statusBarHeight: MediaQuery.of(context).padding.top,
              background: MutableBackground(
                expandedWidget: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.network(
                      restaurant.url!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                collapsedColor: Theme.of(context).colorScheme.primary,
              ),
              children: [
                FlexibleTextItem(
                  text: restaurant.name,
                  expandedStyle: Theme.of(context).textTheme.headline1,
                  collapsedStyle: Theme.of(context).textTheme.headline2,
                  expandedAlignment: Alignment.bottomLeft,
                  collapsedAlignment: Alignment.center,
                  expandedPadding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SingleChildScrollView(
              child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurant.meals.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio:
                          MediaQuery.of(context).size.aspectRatio * 2.7),
                  itemBuilder: (context, index) {
                    return MealWidget(restaurant.meals[index], restaurant);
                  }),
            ),
          ]))
        ],
      ),
    );
  }
}
