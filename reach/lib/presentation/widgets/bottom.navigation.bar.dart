import 'package:flutter/material.dart';

/// bottom navigation item
class ReachBottomNavigationBarItem {
  final IconData icon;
  final String label;

  const ReachBottomNavigationBarItem({required this.icon, required this.label});
}

/// bottom navigation bar
class ReachBottomNavigationBar extends StatelessWidget {
  final List<ReachBottomNavigationBarItem> items;
  final Function(int) onItemTap;
  final int active;

  const ReachBottomNavigationBar({
    Key? key,
    required this.items,
    required this.onItemTap,
    required this.active,
  })  : assert(items.length != 0 && items.length % 2 == 0),
        super(key: key);

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
      color: colorScheme.primaryVariant,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int index = 0; index < items.length; index++) ...{
            _buildItem(context, items[index]),
          },
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
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorScheme.secondary.withOpacity(isCurrentItem ? 0.65 : 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          item.icon,
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }
}
