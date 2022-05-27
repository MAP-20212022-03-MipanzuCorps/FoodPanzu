import 'package:map_mvvm/service_stream.dart';

abstract class FireStorage with ServiceStream {
  Future<void> uploadFile(String filePath, String fileName);
  Future<String> downloadUrl(String imageName);
}
