import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:order_app/providers/addressprovider.dart';
import 'package:order_app/providers/authprovider.dart';
import 'package:order_app/providers/cartprovider.dart';
import 'package:order_app/providers/orderprovider.dart';
import 'package:order_app/providers/restaurant_provider.dart';
import 'package:order_app/screens/addressadd.dart';
import 'package:order_app/screens/addressesscreen.dart';
import 'package:order_app/screens/authscreen.dart';
import 'package:order_app/screens/cartscreen.dart';
import 'package:order_app/screens/checkoutscreen.dart';
import 'package:order_app/screens/mealdetailsscreen.dart';
import 'package:order_app/screens/orderscreen.dart';

import 'package:order_app/screens/restaurant_details.dart';

import 'package:order_app/screens/tabscreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> BackgroundHandler(RemoteMessage message) async {
  print("kkkkk");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(BackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
            create: (_) => OrderProvider(),
            update: (_, auth, previousOrder) {
              return previousOrder!..update(auth.currentUserId);
            }),
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AddressProvider>(
            create: (_) => AddressProvider(),
            update: (_, auth, previousAddress) {
              return previousAddress!..update(auth.currentUser);
            }),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) => SafeArea(child: child!),
              routes: {
                RestaurantDetialPage.routename: (context) =>
                    const RestaurantDetialPage(),
                MealDetailsScreen.routename: (context) => MealDetailsScreen(),
                CartScreen.routename: (context) => CartScreen(),
                OrdersScreen.routename: (context) => const OrdersScreen(),
                CheckOutScreen.routename: (context) => const CheckOutScreen(),
                AddAddressScreen.routename: (context) => AddAddressScreen(),
                AddressesScreen.routename: (context) => AddressesScreen(),
              },
              theme: ThemeData(
                  backgroundColor: Colors.orange[100],
                  fontFamily: 'LuxuriousRoman',
                  colorScheme:
                      ColorScheme.fromSwatch(primarySwatch: Colors.orange)
                          .copyWith(secondary: Colors.orangeAccent),
                  textTheme: const TextTheme(
                      headline1: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                      ),
                      headline6: TextStyle(
                        color: Colors.black,
                      ),
                      headline2: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      headline3: TextStyle(color: Colors.black, fontSize: 25),
                      caption: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 15,
                      ),
                      headline5: TextStyle(color: Colors.orange),
                      headline4: TextStyle(color: Colors.orange))),
              home: auth.isAuth() ? Tab_Screen() : AuthScreen());
        },
      ),
    );
  }
}
