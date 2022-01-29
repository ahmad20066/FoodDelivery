import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  static Future<UploadTask> uploadImage(String folderID, File file) async {
    return FirebaseStorage.instance.ref().child(folderID).putFile(file);
  }

  static Future<String> getUrl(String path) {
    return FirebaseStorage.instance.ref().child(path).getDownloadURL();
  }
}
