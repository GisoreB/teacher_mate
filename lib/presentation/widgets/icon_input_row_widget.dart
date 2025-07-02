import 'package:flutter/material.dart';

class IconInputRow extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final bool isPicker;

  const IconInputRow({
    super.key,
    required this.icon,
    required this.child,
    this.isPicker = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment:
        isPicker ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: isPicker ? 0.0 : 12.0),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(child: child),
          const SizedBox(width: 36),
        ],
      ),
    );
  }
}
