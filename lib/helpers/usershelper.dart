import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:order_app/models/addressmodel.dart';
import 'package:order_app/models/usermodels.dart';

class UsersHelper {
  static var ref = FirebaseFirestore.instance.collection("Users");
  static var collection = ref.withConverter(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (snapshot, _) => snapshot.toJson());
  static Future addUser(UserModel user) {
    return collection.doc(user.userId).set(user);
  }

  static Future<UserModel> getUser(String userId) async {
    final snapshot = await collection.doc(userId).get();
    return snapshot.data()!;
  }

  static Future<void> addAddress(String userId, Address address) async {
    collection.doc(userId).update({
      "addresses": FieldValue.arrayUnion([address.toJson()])
    });
  }

  static Future<void> deleteAddress(String userId, Address address) async {
    collection.doc(userId).update({
      "addresses": FieldValue.arrayRemove([address.toJson()])
    });
  }

  static Stream<DocumentSnapshot<UserModel>> getStream(String userId) {
    return collection.doc(userId).snapshots();
  }
}
