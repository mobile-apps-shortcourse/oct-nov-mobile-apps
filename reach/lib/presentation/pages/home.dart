import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:reach/config/themes.dart';
import 'package:reach/presentation/widgets/bottom.navigation.bar.dart';
import 'package:reach/presentation/widgets/dashboard.card.dart';

part 'tabs/home.dart';

part 'tabs/profile.dart';

part 'tabs/search.dart';

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
      appBar: _activeIndex == 0
          ? AppBar(
              centerTitle: true,
              title: const Text('Dashboard'),
            )
          : null,
      body: Center(
        child: _activeIndex == 0
            ? const HomeTab()
            : _activeIndex == 1
                ? const SearchTab()
                : const ProfileTab(),
      ),
      bottomNavigationBar: ReachBottomNavigationBar(
        active: _activeIndex,
        onItemTap: (index) => setState(() => _activeIndex = index),
      ),
    );
  }
}
