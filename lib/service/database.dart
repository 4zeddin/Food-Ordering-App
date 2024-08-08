import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethodes {
  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({"wallet": amount});
  }

  addFoodItem(Map<String, dynamic> addItem, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(addItem);
  }

  Future<Stream<QuerySnapshot>> getFoodItem(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future<void> addFoodToCart(Map<String, dynamic> addFoodToCart, String id) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .collection("cart")
          .add(addFoodToCart);
  }

  Future<Stream<QuerySnapshot>> getFoodCart(String name) async {
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }
}
