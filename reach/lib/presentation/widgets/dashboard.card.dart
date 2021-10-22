import 'package:flutter/material.dart';

// part 'dashboard.card.g.dart';

// @CopyWith()
/// model class for dashboard content
class DashboardCardItem {
  final Color? background;
  final Color? foreground;
  final String category;
  final IconData icon;
  final String categoryAbbrev;
  final double difference;
  final double value;

  const DashboardCardItem({
    required this.category,
    required this.icon,
    required this.categoryAbbrev,
    this.difference = 0.00,
    this.value = 0.00,
    this.background,
    this.foreground,
  });
}

/// card to show metrics on user's dashboard
class DashboardCard extends StatefulWidget {
  final DashboardCardItem item;
  final Function()? onSelected;

  const DashboardCard({Key? key, required this.item, this.onSelected})
      : super(key: key);

  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
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

    return GestureDetector(
      onTap: widget.onSelected,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: widget.item.background ?? colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: widget.item.background ?? colorScheme.surface,
              offset: const Offset(2, 4),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.categoryAbbrev,
                        style: textTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              widget.item.foreground ?? colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.item.difference.sign == 1 ? '+' : ''}${widget.item.difference}%',
                      style: textTheme.caption?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.item.foreground ?? colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${widget.item.value}',
                  style: textTheme.headline5?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.item.foreground ?? colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.item.foreground ?? colorScheme.onSurface,
                  ),
                  child: Icon(
                    widget.item.icon,
                    size: 16,
                    color: widget.item.background ?? colorScheme.surface,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    widget.item.category,
                    style: textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: widget.item.foreground ?? colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
