import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static final storage = FirebaseStorage.instance;

  static Future<String?> linkConverting(File file) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final ext = file.path.split(".").last;

    final ref = storage.ref().child("profile_picture/$time.$ext");
    await ref
        .putFile(file, SettableMetadata(contentType: "images/*$ext"))
        .then((p0) {
      log("data trasferred:${p0.bytesTransferred / 1000}kb");
    });
    return await ref.getDownloadURL();
  }
}
