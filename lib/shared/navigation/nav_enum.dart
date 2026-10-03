import 'package:flutter/material.dart';

enum NavEnum {
  home(
    activeAsset: 'assets/images/icons/Home2.png',
    inactiveAsset: 'assets/images/icons/Home.png',
    activeIcon: Icons.home_rounded,
    inactiveIcon: Icons.home_outlined,
  ),
  wishlist(
    activeAsset: 'assets/images/icons/favorite.png',
    inactiveAsset: 'assets/images/icons/wishlist.png',
    activeIcon: Icons.favorite_rounded,
    inactiveIcon: Icons.favorite_border_rounded,
  ),
  catalog(
    activeAsset: 'assets/images/icons/categories2.png',
    inactiveAsset: 'assets/images/icons/categories.png',
    activeIcon: Icons.receipt_long_rounded,
    inactiveIcon: Icons.receipt_long_outlined,
  ),
  cart(
    activeAsset: 'assets/images/icons/Bag 2.png',
    inactiveAsset: 'assets/images/icons/Bag 3.png',
    activeIcon: Icons.shopping_bag_rounded,
    inactiveIcon: Icons.shopping_bag_outlined,
  ),
  profile(
    activeAsset: 'assets/images/icons/Profile2.png',
    inactiveAsset: 'assets/images/icons/Profile.png',
    activeIcon: Icons.person_rounded,
    inactiveIcon: Icons.person_outline_rounded,
  );

  final String activeAsset;
  final String inactiveAsset;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const NavEnum({
    required this.activeAsset,
    required this.inactiveAsset,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
