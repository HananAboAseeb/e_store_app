import 'package:flutter/material.dart';

enum NavEnum {
  home(
    activeIcon: Icons.home_rounded,
    inactiveIcon: Icons.home_outlined,
  ),
  wishlist(
    activeIcon: Icons.favorite_rounded,
    inactiveIcon: Icons.favorite_border_rounded,
  ),
  catalog(
    activeIcon: Icons.receipt_long_rounded,
    inactiveIcon: Icons.receipt_long_outlined,
    assetPath: 'assets/images/icons/categories.png',
  ),
  cart(
    activeIcon: Icons.shopping_bag_rounded,
    inactiveIcon: Icons.shopping_bag_outlined,
    assetPath: 'assets/images/icons/Bag 3.png',
  ),
  profile(
    activeIcon: Icons.person_rounded,
    inactiveIcon: Icons.person_outline_rounded,
  );

  final IconData activeIcon;
  final IconData inactiveIcon;
  final String? assetPath;

  const NavEnum({
    required this.activeIcon,
    required this.inactiveIcon,
    this.assetPath,
  });
}
