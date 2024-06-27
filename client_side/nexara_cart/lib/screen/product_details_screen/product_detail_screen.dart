import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/extensions.dart';
import 'package:nexara_cart/utility/functions.dart';
import 'package:provider/provider.dart';

import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import '../../models/product.dart';
import '../../widget/horizondal_list.dart';
import 'components/product_rating_section.dart';
import 'provider/product_detail_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              backgroundColor: Colors.black.withOpacity(0),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //? product image section
                SizedBox(
                  height: height * 0.38,
                  width: width,
                  child: CarouselSlider(items: product.images ?? []),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFECEFF1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //? product nam e
                        Text(
                          '${product.name}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        //? product rating section
                        const ProductRatingSection(),
                        const SizedBox(height: 10),
                        //? product rate , offer , stock section
                        Row(
                          children: [
                            Text(
                              product.offerPrice != null
                                  ? formatCurrency(context, product.offerPrice)
                                  : formatCurrency(context, product.price),
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            const SizedBox(width: 3),
                            Visibility(
                              visible: product.offerPrice != product.price,
                              child: Text(
                                formatCurrency(context, product.price),
                                style: const TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              product.quantity != 0
                                  ? "Available Stock: ${product.quantity}"
                                  : "Not available",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: product.quantity != 0
                                      ? Colors.black
                                      : Colors.red),
                            )
                          ],
                        ),
                        Visibility(
                            visible: product.proVariantId?.isNotEmpty ?? false,
                            child: const SizedBox(height: 20)),
                        Visibility(
                          visible: product.proVariantId?.isNotEmpty ?? false,
                          child: product.proVariantId!.isNotEmpty
                              ? Text(
                                  'Available ${product.proVariantTypeId?.type}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        Visibility(
                          visible: product.proVariantId?.isNotEmpty ?? false,
                          child: Consumer<ProductDetailProvider>(
                            builder: (context, proDetailProvider, child) {
                              return HorizontalList(
                                items: product.proVariantId ?? [],
                                itemToString: (val) => val,
                                selected: proDetailProvider.selectedVariant,
                                onSelect: (val) {
                                  proDetailProvider.selectedVariant = val;
                                  proDetailProvider.updateUI();
                                },
                              );
                            },
                          ),
                        ),
                        //? product description
                        const Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Text(
                            "Description:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text("${product.description}"),
                        const SizedBox(height: 40),
                        //? add to cart button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: product.quantity != 0
                                ? () {
                                    context.productDetailProvider
                                        .addToCart(product);
                                  }
                                : null,
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
