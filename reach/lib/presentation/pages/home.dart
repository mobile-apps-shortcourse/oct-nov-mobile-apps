import 'package:flutter/material.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/bottom.navigation.bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// keeps track of the current page index
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// app theme
    var appTheme = Theme.of(context);

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    /// set system UI overlays when the application is rendered
    /// to the user's display.
    bool isLightTheme = appTheme.brightness == Brightness.light;
    kApplySystemOverlay(
      context,
      systemNavigationBarDividerColor: colorScheme.secondary,
      systemNavigationBarColor: colorScheme.secondary,
      statusBarIconBrightness:
          isLightTheme ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          isLightTheme ? Brightness.dark : Brightness.light,
    );

    return Scaffold(
      body: Center(
        child: Text(
          'Welcome home',
          style: textTheme.headline4,
        ),
      ),
      bottomNavigationBar: ReachBottomNavigationBar(
        active: _activeIndex,
        onItemTap: (index) => setState(() => _activeIndex = index),
      ),
    );
  }
}
