import 'package:flutter/material.dart';

/// primary colored button.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onTap;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// text theme of the application
    var textTheme = Theme.of(context).textTheme;

    /// color scheme of the application
    var colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label.toUpperCase(),
              style: textTheme.button,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(icon, color: colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
