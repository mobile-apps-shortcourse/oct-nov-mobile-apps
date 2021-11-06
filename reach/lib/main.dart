import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reach/app.dart';
import 'package:reach/config/injector.dart';

/// use this script to generate your build files
/// flutter packages pub run build_runner build

/// this is the entry point of the application
void main() async {
  /// flutter is initialized properly on target device
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize all dependencies
  await Injector.init();

  /// enables Riverpod for the entire project
  runApp(const ProviderScope(child: ReachApp()));
}
