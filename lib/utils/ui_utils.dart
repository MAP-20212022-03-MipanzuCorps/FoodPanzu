import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:map_mvvm/failure.dart';

/// Try running a callback. When error happened,
/// it will open an error snackbar
///
Future<void> showSnackBarWhenError(
    BuildContext context, AsyncCallback callback) async {
  try {
    await callback();
  } on Failure catch (f) {
    final snackbar = SnackBar(
      content: Text(f.message ?? 'Error'),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
