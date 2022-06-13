import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:foodpanzu/app/failures.dart';
import 'package:foodpanzu/services/firebase/firestorage_service.dart';
import 'package:map_mvvm/map_mvvm.dart';

class FireStorageImpl extends FireStorage {
  String menuPath = 'menu';
  final firebaseStorage = FirebaseStorage.instance;
  @override
  Future<void> uploadFile(
      String filePath, String fileName, String restId) async {
    File file = File(filePath);

    try {
      await firebaseStorage
          .ref(menuPath + "/" + restId + "/" + fileName)
          .putFile(file);
    } on FirebaseException catch (e) {
      throw Failure("100",
          message: e.message, location: "FireStorageImpl.dart");
    }
  }

  @override
  Future<String> downloadUrl(String imageName) async {
    try {
      return await firebaseStorage.ref(imageName).getDownloadURL();
    } on FirebaseException catch (e) {
      throw Failure("100",
          message: e.message, location: "FireStorageImpl.dart");
    }
  }

  @override
  deleteFile(String ref) async {
    // TODO: implement deleteFile
    await firebaseStorage.ref(ref).delete();
  }
}
