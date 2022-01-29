import 'package:flutter/material.dart';
import 'package:order_app/screens/profile.dart';
import 'package:order_app/screens/rest_overview.dart';

class Tab_Screen extends StatefulWidget {
  const Tab_Screen({Key? key}) : super(key: key);

  @override
  _Tab_ScreenState createState() => _Tab_ScreenState();
}

class _Tab_ScreenState extends State<Tab_Screen> {
  List<Map<String, dynamic>> pages = [
    {'page': Rest_Overview(), 'title': "Restaurants"},
    {'page': const Profile_Screen(), 'title': "Your profile"}
  ];
  int selectedpageindex = 0;
  void selectPage(int index) {
    setState(() {
      selectedpageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedpageindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        selectedItemColor: Colors.orange,
        selectedIconTheme: const IconThemeData(color: Colors.orange, size: 30),
        unselectedIconTheme: const IconThemeData(color: Colors.black, size: 20),
        onTap: selectPage,
        currentIndex: selectedpageindex,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_outlined), label: "Restaurants"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
