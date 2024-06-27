import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth * 0.7,
                child: AspectRatio(
                  aspectRatio: 1,
                  // Set this to the actual aspect ratio of your image
                  child: Image.asset('assets/images/empty_cart.png'),
                ),
              );
            },
          ),
          const SizedBox(height: 20), // Add spacing if needed
          const Text(
            "Your cart is empty!",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
