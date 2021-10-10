import 'package:flutter/material.dart';

/// primary colored button.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onTap;
  final Color? background;
  final Color? foreground;
  final bool outlined;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
    this.background,
    this.foreground,
    this.outlined = false,
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
          color: outlined
              ? Colors.transparent
              : background ?? colorScheme.primary,
          borderRadius: BorderRadius.circular(28),
          border: outlined
              ? Border.all(color: background ?? colorScheme.primaryVariant, width: 2)
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: textTheme.button
                  ?.copyWith(color: foreground ?? colorScheme.onPrimary),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(icon, color: foreground ?? colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
