import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_app/models/ordermodel.dart';

class OrderHelper {
  static var ref = FirebaseFirestore.instance.collection("Orders");
  static var collection = ref.withConverter(
      fromFirestore: (snapshot, _) => OrderModel.fromJson(snapshot.data()!),
      toFirestore: (snapshot, _) => snapshot.toJson());
  static Future<void> addOrder(OrderModel order) {
    return collection.doc(order.id).set(order);
  }

  static Future<List<DocumentSnapshot<OrderModel>>> getOrders(
      String userId) async {
    final snapsots = await collection.get();
    return snapsots.docs
        .where((element) => element.data().userID == userId)
        .toList();
  }
}
