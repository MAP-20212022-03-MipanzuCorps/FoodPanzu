// ignore_for_file: unnecessary_const

import 'package:map_mvvm/map_mvvm.dart';

class Failures {
  static const cannotRead = const Failure(100, message: 'Cannot read data');
  static const cannotWrite = const Failure(101, message: 'Cannot write data');
}
