import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:order_app/models/restaurant.dart';

class FireStore {
  late String? url;
  static CollectionReference ref =
      FirebaseFirestore.instance.collection('Restaurants');
  static final collection = ref.withConverter<Restaurant>(
      fromFirestore: (snapshot, _) => Restaurant.fromJson(snapshot.data()!),
      toFirestore: (snapshot, _) => snapshot.toJson());
  static Future<void> addRestaurant(Restaurant restaurant) {
    return collection.doc(restaurant.id).set(restaurant);
  }

  static Future<List<DocumentSnapshot<Restaurant>>> get() async {
    final snapshots =
        await collection.orderBy("isOnline", descending: true).get();
    return snapshots.docs;
  }

  static Stream<DocumentSnapshot<Restaurant>> getStream(Restaurant restaurant) {
    return collection.doc(restaurant.id).snapshots();
  }
}
