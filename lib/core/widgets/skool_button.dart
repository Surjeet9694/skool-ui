import 'package:flutter/material.dart';

/// Reusable primary button with loading state support.
class SkoolButton extends StatelessWidget {
  const SkoolButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.variant = SkoolButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final SkoolButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget child = isLoading
        ? SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: switch (variant) {
                SkoolButtonVariant.primary => colorScheme.onPrimary,
                SkoolButtonVariant.outlined => colorScheme.primary,
              },
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, size: 18),
              ],
            ],
          );

    return switch (variant) {
      SkoolButtonVariant.primary => ElevatedButton(
          onPressed: onPressed,
          child: child,
        ),
      SkoolButtonVariant.outlined => OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
    };
  }
}

enum SkoolButtonVariant { primary, outlined }
