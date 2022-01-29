import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:order_app/helpers/firestorehelper.dart';
import 'package:order_app/models/restaurant.dart';

import 'package:order_app/screens/restaurant_details.dart';

class RestaurantWidget extends StatefulWidget {
  Restaurant restaurant;
  RestaurantWidget(this.restaurant);
  @override
  _RestaurantWidgetState createState() => _RestaurantWidgetState();
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RestaurantDetialPage.routename,
            arguments: widget.restaurant.id);
      },
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.restaurant.url!,
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                //height: MediaQuery.of(context).size.height * 0.05,
                color: Colors.white70,
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.restaurant.logoUrl!),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  widget.restaurant.name,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Text(
                                  widget.restaurant.location,
                                  style: Theme.of(context).textTheme.caption,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream:
                                      FireStore.getStream(widget.restaurant),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.waiting ||
                                        !snapshot.hasData) {
                                      return const CircularProgressIndicator();
                                    }

                                    return Row(
                                      children: [
                                        Icon(
                                          Icons.lens,
                                          size: 15,
                                          color: snapshot.data!["isOnline"] ==
                                                  false
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                        Text(
                                          snapshot.data!["isOnline"] == false
                                              ? "Offline"
                                              : "Online",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ],
                                    );
                                  }),
                            ),
                            Text(
                              "Delivery Fee : ${widget.restaurant.deliveryFee}\$",
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
