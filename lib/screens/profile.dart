import 'package:flutter/material.dart';
import 'package:order_app/providers/authprovider.dart';
import 'package:order_app/screens/addressesscreen.dart';
import 'package:order_app/screens/orderscreen.dart';
import 'package:provider/provider.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  bool isLoading = false;
  Widget gridTileBuilder(
      BuildContext context, String route, String title, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Card(
        child: GridTile(
            footer: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  icon,
                  color: Colors.orange,
                  size: 90,
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          color: Colors.orange[100],
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: const Image(
            image: AssetImage(
              "assets/pngfind.com-bee-png-584074.png",
            ),
          ),
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: Container(
                    padding: const EdgeInsets.all(8),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      children: [
                        gridTileBuilder(context, OrdersScreen.routename,
                            "View your orders", Icons.shopping_cart_outlined),
                        gridTileBuilder(context, AddressesScreen.routename,
                            "View your addresses", Icons.location_city),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .logOut();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Card(
                            child: GridTile(
                                footer: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "LogOut",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Icon(
                                      Icons.logout_outlined,
                                      color: Colors.orange,
                                      size: 90,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              )
      ],
    ));
  }
}
