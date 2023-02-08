import 'package:flutter/material.dart';
import 'package:messenger_app/theme.dart';

class IconBackground extends StatelessWidget {
  const IconBackground({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        // InkWell implements the blue tap effect
        borderRadius: BorderRadius.circular(
            6), // ensures effect has soft cornders like the Material parent
        splashColor: AppColors.secondary,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 18),
        ),
      ),
    );
  }
}
