import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/animation/open_container_wrapper.dart';
import '../../utility/app_color.dart';
import '../../utility/extensions.dart';
import '../../widget/navigation_tile.dart';
import '../auth_screen/login_screen.dart';
import '../my_address_screen/my_address_screen.dart';
import '../my_order_screen/my_order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          56.0,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: AppBar(
              leading: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              elevation: 0.0,
              title: const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkAccent),
              ),
              backgroundColor: Colors.black.withOpacity(0),
            ),
          ),
        ),
      ),
      body: ListView(
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(
            height: 200,
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  'assets/images/profile_pic.png',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "${context.userProvider.getLoginUsr()?.name}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 40),
          const OpenContainerWrapper(
            nextScreen: MyOrderScreen(),
            child: NavigationTile(
              icon: Icons.list,
              title: 'Order History',
            ),
          ),
          const SizedBox(height: 15),
          const OpenContainerWrapper(
            nextScreen: MyAddressPage(),
            child: NavigationTile(
              icon: Icons.location_on,
              title: 'Shipping Address',
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.darkAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
                context.userProvider.logOutUser();
                Get.offAll(const LoginScreen());
              },
              child: const Text('Logout', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
