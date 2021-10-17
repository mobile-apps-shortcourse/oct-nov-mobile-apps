import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach/app.dart';
import 'package:reach/config/dependency.injection.dart';

/// this is the entry point of the application
void main() async {
  /// wait for flutter to be properly injected into mobile app
  WidgetsFlutterBinding.ensureInitialized();

  /// inject dependencies
  await Injector.inject();

  /// run app
  runApp(const ProviderScope(child: ReachApp()));
}
