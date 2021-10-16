import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach/app.dart';

/// this is the entry point of the application
void main() async {
  /// wait for flutter to be properly injected into mobile app
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase
  await Firebase.initializeApp();

  /// run app
  runApp(const ProviderScope(child: ReachApp()));
}
