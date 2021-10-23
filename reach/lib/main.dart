import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reach/app.dart';

/// this is the entry point of the application
void main() async {

  /// flutter is initialized properly on target device
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase application
  var firebaseApp = await Firebase.initializeApp();
  /// [DEFAULT]
  print('Firebase application initialized as ${firebaseApp.name}');

  runApp(ReachApp());
}

