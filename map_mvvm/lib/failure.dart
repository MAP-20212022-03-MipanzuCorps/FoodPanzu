// Change the class name, since Error is already used in Flutter
class Failure {
  final int code;
  final String? message;

  const Failure(this.code, [this.message = '']);
}
