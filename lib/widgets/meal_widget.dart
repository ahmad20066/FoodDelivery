import 'package:flutter/material.dart';
import 'package:order_app/models/meals.dart';
import 'package:order_app/models/restaurant.dart';
import 'package:order_app/providers/restaurant_provider.dart';
import 'package:order_app/screens/mealdetailsscreen.dart';
import 'package:provider/provider.dart';

class MealWidget extends StatefulWidget {
  Meal meal;
  Restaurant restaurant;
  MealWidget(this.meal, this.restaurant);

  @override
  _MealWidgetState createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          MealDetailsScreen.routename,
          arguments: {
            'id': widget.meal.id,
            'restaurant': widget.restaurant,
          },
        );
      },
      child: Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(children: [
                FutureBuilder<Image>(
                    future: Provider.of<RestaurantProvider>(context).loadImage(
                        "${widget.restaurant.name}/${widget.meal.name}/${widget.meal.id}.jpg"),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
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
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    color: Colors.black45,
                    child: Text(
                      widget.meal.name,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 40,
                    color: Colors.black45,
                    child: Text("${widget.meal.price}\$",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                ),
              ]),
              Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.white38,
                child: widget.meal.description == null
                    ? Text(
                        "No description",
                        style: Theme.of(context).textTheme.caption,
                        // maxLines: 3,
                      )
                    : Text(
                        widget.meal.description!,
                        style: Theme.of(context).textTheme.caption,
                        // maxLines: 3,
                        overflow: TextOverflow.clip,
                      ),
              )
            ],
          )),
    );
  }
}
