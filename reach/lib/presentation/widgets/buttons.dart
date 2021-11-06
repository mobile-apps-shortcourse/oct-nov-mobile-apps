import 'package:flutter/material.dart';

/// primary colored button.
class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onTap;
  final bool outline;
  final Color? background;
  final Color? foreground;

  const PrimaryButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onTap,
    this.outline = false,
    this.background,
    this.foreground,
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
          color:
              outline ? Colors.transparent : background ?? colorScheme.primary,
          // color: background == null ? colorScheme.primary : background!,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(24),
          border: outline
              ? Border.all(color: colorScheme.primaryVariant, width: 2)
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: textTheme.button?.copyWith(
                color: foreground ??
                    (outline
                        ? colorScheme.primaryVariant
                        : colorScheme.onPrimary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                icon,
                color: foreground ??
                    (outline
                        ? colorScheme.primaryVariant
                        : colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
