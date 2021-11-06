import 'package:flutter/material.dart';

/// extension on the BuildContext class
extension BuildContextX on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message, style : TextStyle(
          color: Theme.of(this).colorScheme.background,
        )),
      ));
  }
}
