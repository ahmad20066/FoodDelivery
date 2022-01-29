import 'package:flutter/material.dart';
import 'package:order_app/providers/restaurant_provider.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  Function search;
  SearchBar(this.search);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(10),
      child: TextField(
        cursorColor: Colors.orange,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: Colors.orange[200],
            hintText: "Search for a Restaurant..",
            hintStyle: const TextStyle(
              color: Colors.black,
            )),
        onChanged: (val) {
          widget.search(controller.text);
          Provider.of<RestaurantProvider>(context, listen: false).get();

          setState(() {});
        },
      ),
    );
  }
}
