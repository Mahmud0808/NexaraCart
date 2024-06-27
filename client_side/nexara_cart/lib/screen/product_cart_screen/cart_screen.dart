import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/functions.dart';
import 'package:provider/provider.dart';

import '../../utility/animation/animated_switcher_wrapper.dart';
import '../../utility/app_color.dart';
import '../../utility/extensions.dart';
import 'components/buy_now_bottom_sheet.dart';
import 'components/cart_list_section.dart';
import 'components/empty_cart.dart';
import 'provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.cartProvider.getCartItems();
    });

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
                "My Cart",
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
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cartProvider.myCartItems.isEmpty
                  ? const EmptyCart()
                  : Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return CartListSection(
                            cartProducts: cartProvider.myCartItems);
                      },
                    ),
              //? total price section
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: AppColor.darkAccent,
                              ),
                            ),
                            AnimatedSwitcherWrapper(
                              child: Text(
                                formatCurrency(
                                    context, cartProvider.getCartSubTotal()),
                                // key: ValueKey<double>(cartProvider.getCartSubTotal()),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.darkAccent,
                                ),
                              ),
                            )
                          ],
                        ),
                        //? buy now button
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ElevatedButton(
                              onPressed:
                                  context.cartProvider.myCartItems.isEmpty
                                      ? null
                                      : () {
                                          showCustomBottomSheet(context);
                                        },
                              child: const Padding(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
