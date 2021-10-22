import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  void showSnackBar(
    String message, {
    Color? foreground,
    Color? background,
  }) {
    var appTheme = Theme.of(this);
    var textTheme = appTheme.textTheme;
    var colorScheme = appTheme.colorScheme;

    ScaffoldMessenger.of(this)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              message,
              style: textTheme.button
                  ?.copyWith(color: foreground ?? colorScheme.background),
            ),
          ),
          backgroundColor: background ?? colorScheme.primaryVariant,
        ),
      );
  }
}

/// used when calling context in [StatefulWidget#initState]
void doAfterDelay(Function() block) =>
    Future.delayed(const Duration()).then((value) => block());
