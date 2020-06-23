import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  final _provider = Firestore.instance;

  Stream<QuerySnapshot> getMenuCategories() {
    return _provider.collection("category").snapshots();
  }

  Stream<DocumentSnapshot> getUser(String userEmail) {
    return _provider.document("users/$userEmail").snapshots();
  }

  Future<void> saveNewCategory(Map<String, dynamic> category) {
    return _provider.document("category/${category['name']}").setData(category);
  }

  Stream<QuerySnapshot> getMenuItems(String category, String vendor) {
    return _provider
        .collection("menu")
        .where("category", isEqualTo: category)
        .where("vendor", isEqualTo: vendor)
        .snapshots();
  }

  Stream<DocumentSnapshot> getVendorInfo(String vendorName) {
    return _provider.document("vendors/Burger House").snapshots();
  }

  Future<void> saveMenuItem(Map<String, dynamic> newItem) {
    return _provider.document("menu/${newItem['createdAt']}").setData(newItem);
  }

  Stream<DocumentSnapshot> getItem(String createdAt) {
    return _provider.document("menu/$createdAt").snapshots();
  }

  Future<void> updateAvaibility(bool value, String createdAt) {
    return _provider
        .document("menu/$createdAt")
        .updateData({"isAvailable": value});
  }

  // For setting business
  Future<void> updateStatus(bool value, String vendor) {
    return _provider.document("vendors/$vendor").updateData({"isBusy": value});
  }

  // For Viewig orders
  Stream<QuerySnapshot> getLiveOnlineOrders(String vendor) {
    return _provider
        .collection("liveOnlineOrders")
        .where("vendor", isEqualTo: vendor)
        .snapshots();
  }

  Future<void> setLiveOrderStatus(String orderId, List<String> newStatus) {
    return _provider
        .document("liveOnlineOrders/$orderId")
        .updateData({"status": newStatus});
  }
}
