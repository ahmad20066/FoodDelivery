import 'package:flutter/cupertino.dart';
import 'package:order_app/helpers/firestorehelper.dart';
import 'package:order_app/helpers/storagehelper.dart';

import 'package:order_app/models/meals.dart';
import 'package:order_app/models/restaurant.dart';

class RestaurantProvider with ChangeNotifier {
  List<Restaurant> _restaurants = [];
  Map<String, String> urls = {};

  List<Restaurant> get restaurants {
    return [..._restaurants];
  }

  Future<void> get() async {
    List<Restaurant> fetchedData = [];
    final ss = await FireStore.get();

    for (var element in ss) {
      fetchedData.add(element.data()!);
      notifyListeners();
    }
    _restaurants = fetchedData;
    print(restaurants);
    notifyListeners();
  }

  Future<void> uploadImages(Restaurant addedRestaurant) async {
    for (Meal meal in addedRestaurant.meals) {
      await StorageHelper.uploadImage(
          "${addedRestaurant.name}/${meal.name}/${meal.id}", meal.image);
    }
    final task = await StorageHelper.uploadImage(
        "${addedRestaurant.name}/${addedRestaurant.name}/${addedRestaurant.id}",
        addedRestaurant.image);
    final path = await task;
    print(path.ref);
    String restaurantUrl = await StorageHelper.getUrl(
        "${addedRestaurant.name}/${addedRestaurant.name}/${addedRestaurant.id}");
    await FireStore.ref.doc(addedRestaurant.id).update({'url': restaurantUrl});

    await StorageHelper.uploadImage(
        "${addedRestaurant.name}/ logo/${addedRestaurant.id}logo",
        addedRestaurant.logo);
    String logoUrl = await StorageHelper.getUrl(
        "${addedRestaurant.name}/${addedRestaurant.name}/${addedRestaurant.id}");
    FireStore.ref.doc(addedRestaurant.id).update({'logoUrl': logoUrl});
  }

  Future<Image> loadImage(String folderID) {
    print(folderID);
    return StorageHelper.getUrl(folderID).then((value) {
      return Image(
        image: NetworkImage(value),
        fit: BoxFit.cover,
      );
    });
  }

  Future<void> addRestaurant(Restaurant addedRestaurant) async {
    restaurants.add(addedRestaurant);
    notifyListeners();

    await FireStore.addRestaurant(addedRestaurant);
    await uploadImages(addedRestaurant);
  }

  Restaurant findRestaurantByID(String id) {
    return _restaurants.firstWhere((element) => element.id == id);
  }

  Meal findMealByID(String id, Restaurant restaurant) {
    return restaurant.meals.firstWhere((element) => element.id == id);
  }

  List<Restaurant> Search(String searchString) {
    return restaurants
        .where((element) => element.name.contains(searchString))
        .toList();
  }
}
