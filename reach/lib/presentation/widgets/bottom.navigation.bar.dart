import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

/// bottom navigation item
class ReachBottomNavigationBarItem {
  final IconData icon;
  final String label;

  const ReachBottomNavigationBarItem({required this.icon, required this.label});
}

/// bottom navigation bar
class ReachBottomNavigationBar extends StatelessWidget {
  final List<ReachBottomNavigationBarItem> items = [
    const ReachBottomNavigationBarItem(
      icon: Icons.dashboard_customize,
      label: 'Home',
    ),
    const ReachBottomNavigationBarItem(
      icon: Icons.router,
      label: 'Home',
    ),
    const ReachBottomNavigationBarItem(
      icon: Icons.stream,
      label: 'Home',
    ),
    const ReachBottomNavigationBarItem(
      icon: Icons.person,
      label: 'Profile',
    ),
  ];
  final Function(int) onItemTap;
  final int active;

  ReachBottomNavigationBar({
    Key? key,
    required this.onItemTap,
    required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: kBottomNavigationBarHeight,
      width: width,
      color: colorScheme.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildItem(context, items[0]),
          _buildItem(context, items[1]),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              /// show sliding sheet
              MaterialPageRoute(builder: (context) => const Scaffold()),
            ),
            child: Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.onSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(Entypo.plus, color: colorScheme.secondary),
            ),
          ),
          _buildItem(context, items[2]),
          _buildItem(context, items[3]),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, ReachBottomNavigationBarItem item) {
    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    var isCurrentItem = items.indexOf(item) == active;

    return GestureDetector(
      onTap: () => onItemTap(items.indexOf(item)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: 48,
        height: 48,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   color: colorScheme.background.withOpacity(isCurrentItem ? 0.25 : 0),
        //   borderRadius: BorderRadius.circular(8),
        // ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: isCurrentItem
                  ? colorScheme.onBackground
                  : colorScheme.onSecondary,
            ),
            if (isCurrentItem)
              Text(
                item.label,
                style: textTheme.overline?.copyWith(
                  color: isCurrentItem
                      ? colorScheme.onBackground
                      : colorScheme.onSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
