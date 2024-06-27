import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/product_summery_info.dart';
import '../../../utility/constants.dart';
import 'product_summery_card.dart';

class ProductSummerySection extends StatelessWidget {
  const ProductSummerySection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        int totalProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: null);
        int outOfStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 0);
        int limitedStockProduct =
            context.dataProvider.calculateProductWithQuantity(quantity: 1);
        int otherStockProduct =
            totalProduct - outOfStockProduct - limitedStockProduct;

        List<ProductSummeryInfo> productSummeryItems = [
          ProductSummeryInfo(
            title: ALL_PRODUCTS,
            productsCount: totalProduct,
            svgSrc: "assets/icons/Product1.svg",
            color: primaryColor,
            percentage: totalProduct != 0 ? 100 : 0,
          ),
          ProductSummeryInfo(
            title: STOCK_OUT_PRODUCTS,
            productsCount: outOfStockProduct,
            svgSrc: "assets/icons/Product2.svg",
            color: Color(0xFFEA3829),
            percentage: totalProduct != 0
                ? (outOfStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummeryInfo(
            title: LIMITED_STOCK_PRODUCTS,
            productsCount: limitedStockProduct,
            svgSrc: "assets/icons/Product3.svg",
            color: Color(0xFFECBE23),
            percentage: totalProduct != 0
                ? (limitedStockProduct / totalProduct) * 100
                : 0,
          ),
          ProductSummeryInfo(
            title: OTHER_PRODUCTS,
            productsCount: otherStockProduct,
            svgSrc: "assets/icons/Product4.svg",
            color: Color(0xFF47e228),
            percentage: totalProduct != 0
                ? (otherStockProduct / totalProduct) * 100
                : 0,
          ),
        ];

        return Column(
          children: [
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productSummeryItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: defaultPadding,
                mainAxisSpacing: defaultPadding,
                childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
              ),
              itemBuilder: (context, index) => ProductSummeryCard(
                info: productSummeryItems[index],
                onTap: (productType) {
                  context.dataProvider
                      .filterProductsByQuantity(productType ?? '');
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
