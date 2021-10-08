import 'package:flutter/material.dart';
import 'package:reach/config/constants.dart';

/// splash page -> this is the first page any user sees when the application
/// is first launched.
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                applicationName,
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              Container(
                decoration: BoxDecoration(

                ),
              ),
            ],
          ),

          // text
          Text(''),

          // button
          Container(),
        ],
      ),
    );
  }
}
