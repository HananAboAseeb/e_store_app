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
    activeIcon: Icons.grid_view_rounded,
    inactiveIcon: Icons.grid_view_outlined,
  ),
  cart(
    activeIcon: Icons.shopping_bag_rounded,
    inactiveIcon: Icons.shopping_bag_outlined,
  ),
  profile(
    activeIcon: Icons.person_rounded,
    inactiveIcon: Icons.person_outline_rounded,
  );

  final IconData activeIcon;
  final IconData inactiveIcon;

  const NavEnum({
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
