import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';

class FireStorageImpl extends FireStorage {
  final firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await firebaseStorage.ref(fileName).putFile(file);
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  @override
  Future<String> downloadUrl(String imageName) async {
    return await firebaseStorage.ref(imageName).getDownloadURL();
  }
}
