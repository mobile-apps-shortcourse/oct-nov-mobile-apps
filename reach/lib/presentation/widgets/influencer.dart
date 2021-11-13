import 'package:flutter/material.dart';
import 'package:reach/model/user.dart';

/// widget for creating an influencer in a list
class InfluencerListTile extends StatelessWidget {
  final UserAccount influencer;
  final Function() onTap;

  const InfluencerListTile({
    Key? key,
    required this.influencer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// dimensions of the current display
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var kTheme = Theme.of(context);

    /// color scheme of the application
    var colorScheme = kTheme.colorScheme;
    var textTheme = kTheme.textTheme;

    // removing the stack since it's having only one child (Positioned)
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: colorScheme.background,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    influencer.username,
                    style: textTheme.subtitle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '22K+ audiences',
                    style: textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
