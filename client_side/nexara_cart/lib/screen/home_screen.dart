import 'dart:async';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/constants.dart';

import '../../../utility/app_data.dart';
import '../../../widget/page_wrapper.dart';
import '../utility/functions.dart';
import '../utility/snack_bar_helper.dart';
import 'product_cart_screen/cart_screen.dart';
import 'product_favorite_screen/favorite_screen.dart';
import 'product_list_screen/product_list_screen.dart';
import 'profile_screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const List<Widget> screens = [
    ProductListScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;

  @override
  void initState() {
    super.initState();
    checkServerConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              newIndex = index;
            });
          },
          selectedIndex: newIndex,
          destinations: AppData.bottomNavBarItems
              .map(
                (item) => NavigationDestination(
                  icon: item.icon,
                  label: item.title,
                  selectedIcon: item.icon, // Use same icon for simplicity
                ),
              )
              .toList(),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: HomeScreen.screens[newIndex],
        ),
      ),
    );
  }
}
