import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:order_app/models/restaurant.dart';
import 'package:order_app/providers/restaurant_provider.dart';

import 'package:order_app/widgets/restaurant_widget.dart';
import 'package:order_app/widgets/searchbar.dart';
import 'package:provider/provider.dart';

class Rest_Overview extends StatefulWidget {
  @override
  State<Rest_Overview> createState() => _Rest_OverviewState();
}

class _Rest_OverviewState extends State<Rest_Overview> {
  late Future<void> future;
  String searchString = '';
  bool isSearch = false;
  bool isInit = true;
  bool OrderSuccess = false;
  void _Search(String controllerText) {
    searchString = controllerText;
  }

  @override
  void initState() {
    future = Provider.of<RestaurantProvider>(context, listen: false).get();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final route = event.data['route'];
      final id = event.data['id'];
      print(route);
      print(id);
      Navigator.of(context).pushNamed(route, arguments: id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(double.infinity, MediaQuery.of(context).size.height * 0.15),
          child: AppBar(
            flexibleSpace: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/bee-png-45393.png"),
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "OrderApp",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.search),
                      SearchBar(_Search),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Provider.of<RestaurantProvider>(context, listen: false)
                .get();
          },
          child: FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<Restaurant> restaurants = isSearch
                    ? Provider.of<RestaurantProvider>(context)
                        .Search(searchString)
                    : Provider.of<RestaurantProvider>(context).restaurants;

                return Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Restaurants",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio:
                                      MediaQuery.of(context).size.aspectRatio *
                                          3.5),
                          itemCount: restaurants.length,
                          itemBuilder: (BuildContext context, int index) {
                            return RestaurantWidget(restaurants[index]);
                          }),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
