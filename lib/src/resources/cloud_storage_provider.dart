import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageProvider {
  final _provider = FirebaseStorage.instance;

  // Upload food image to server
  Future<StorageTaskSnapshot> uploadFoodImageToServer(
      File imageFile, String filename) {
    return _provider
        .ref()
        .child("photos/$filename")
        .putFile(imageFile)
        .onComplete;
  }
}
