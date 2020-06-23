import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastibtmsadmin/src/models/category.dart';
import 'package:fastibtmsadmin/src/models/menu_item.dart';
import 'package:fastibtmsadmin/src/models/user.dart';
import 'package:fastibtmsadmin/src/models/online_order.dart';
import 'package:fastibtmsadmin/src/models/vendor.dart';
import 'package:fastibtmsadmin/src/resources/auth_provider.dart';
import 'package:fastibtmsadmin/src/resources/cloud_storage_provider.dart';
import 'package:fastibtmsadmin/src/resources/firebase_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Repository {
  final _authProvider = AuthProvider();
  final _cloudStorageProvider = CloudStorageProvider();
  final _firebaseProvider = FirebaseProvider();

  // For login purposes

  Future<AuthResult> logIn(String email, String password) =>
      _authProvider.signIn(email, password);

  Future<void> logOut() => _authProvider.signOut();

  Stream<User> getUser(String userEmail) => _firebaseProvider
          .getUser(userEmail)
          .transform(StreamTransformer.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        if (snapshot.exists) {
          sink.add(parseJsonToUser(snapshot.data));
        }
      }));

  Stream<User> userStatus() => _authProvider.authStatus().transform(
          StreamTransformer<FirebaseUser, User>.fromHandlers(
              handleData: (FirebaseUser user, sink) {
        if (user != null) {
          sink.add(parseJsonToUser({
            "name": user.displayName,
            "email": user.email,
            "password": "",
            "photoUrl": user.photoUrl
          }));
        } else {
          sink.addError("No User found");
        }
      }));

  //  For database  purposes

  Stream<List<ItemCategory>> getMenuCategories() =>
      _firebaseProvider.getMenuCategories().transform(
          StreamTransformer<QuerySnapshot, List<ItemCategory>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<ItemCategory> items = [];
        snapshot.documents.forEach((document) {
          items.add(parseJsonToItemCategory(document.data));
        });
        sink.add(items);
      }));

  Stream<List<MenuItem>> getMenuItems(String category, String vendor) =>
      _firebaseProvider.getMenuItems(category, vendor).transform(
          StreamTransformer<QuerySnapshot, List<MenuItem>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<MenuItem> items = [];
        snapshot.documents.forEach((document) {
          items.add(parseJsonToMenuItem(document.data));
        });
        sink.add(items);
      }));
  Stream<bool> getItemAvaibility(String createdAt) => _firebaseProvider
          .getItem(createdAt)
          .transform(StreamTransformer<DocumentSnapshot, bool>.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        if (snapshot.exists) {
          sink.add(snapshot.data['isAvailable']);
        } else {
          sink.addError("There is an error");
        }
      }));

  Future<void> changeAvaibility(bool value, String createdAt) =>
      _firebaseProvider.updateAvaibility(value, createdAt);

  Future<void> saveNewItem(Map<String, dynamic> newItem) =>
      _firebaseProvider.saveMenuItem(newItem);

  Future<void> saveNewCategory(Map<String, dynamic> category) =>
      _firebaseProvider.saveNewCategory(category);

  Stream<Vendor> getVendorInfo(String vendorName) => _firebaseProvider
          .getVendorInfo(vendorName)
          .transform(StreamTransformer.fromHandlers(
              handleData: (DocumentSnapshot snapshot, sink) {
        if (snapshot.exists) {
          sink.add(parseJsonToVendor(snapshot.data));
        } else {
          sink.addError("No Vendor Found");
        }
      }));

  // For onlineOrders

  Stream<List<OnlineOrder>> getLiveOnlineOrders(String vendor) =>
      _firebaseProvider.getLiveOnlineOrders(vendor).transform(
          StreamTransformer<QuerySnapshot, List<OnlineOrder>>.fromHandlers(
              handleData: (QuerySnapshot snapshot, sink) {
        List<OnlineOrder> liveOrders = [];
        snapshot.documents.forEach((document) {
          liveOrders.add(parseJsonToOnlineOrder(document.data));
        });
        sink.add(liveOrders);
      }));

  Future<void> setLiveOrderStatus(String orderId, List<String> newStatus) =>
      _firebaseProvider.setLiveOrderStatus(orderId, newStatus);

  // Used to save file
  Future<StorageTaskSnapshot> savePhoto(File imageFile, String filename) =>
      _cloudStorageProvider.uploadFoodImageToServer(imageFile, filename);

  Future<void> updateStatus(bool value, String vendor) =>
      _firebaseProvider.updateStatus(value, vendor);
}
