import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/extensions.dart';
import 'package:provider/provider.dart';

import '../../models/brand.dart';
import '../../models/category.dart';
import '../../models/sub_category.dart';
import '../../utility/app_color.dart';
import '../../utility/constants.dart';
import '../../widget/custom_dropdown.dart';
import '../../widget/horizondal_list.dart';
import '../../widget/multi_select_drop_down.dart';
import '../../widget/product_grid_view.dart';
import 'provider/product_by_category_provider.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final Category selectedCategory;

  const ProductByCategoryScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.productByCategoryProvider
          .filterInitialProductAndSubCategory(selectedCategory);
    });

    return Scaffold(
      body: CustomScrollView(
        clipBehavior: Clip.none,
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            surfaceTintColor: Theme.of(context).colorScheme.surface,
            floating: true,
            snap: true,
            title: Text(
              "${selectedCategory.name}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.darkAccent),
            ),
            expandedHeight: 190.0,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                var top = constraints.biggest.height;

                return Stack(
                  children: [
                    Positioned(
                      top: top - 145,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Consumer<ProductByCategoryProvider>(
                            builder: (context, proByCatProvider, child) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: HorizontalList(
                                  items: proByCatProvider.subCategories,
                                  itemToString: (SubCategory? val) =>
                                      val?.name ?? '',
                                  selected:
                                      proByCatProvider.mySelectedSubCategory,
                                  onSelect: (val) {
                                    if (val != null) {
                                      context.productByCategoryProvider
                                          .filterProductBySubCategory(val);
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown<String>(
                                    hintText: 'Sort By Price',
                                    items: const [
                                      SORT_PRICE_LOW_TO_HIGH,
                                      SORT_PRICE_HIGH_TO_LOW
                                    ],
                                    onChanged: (val) {
                                      if (val == SORT_PRICE_LOW_TO_HIGH) {
                                        context.productByCategoryProvider
                                            .sortProducts(ascending: true);
                                      } else {
                                        context.productByCategoryProvider
                                            .sortProducts(ascending: false);
                                      }
                                    },
                                    displayItem: (val) => val,
                                    bgColor: Colors.blueGrey[50]!,
                                  ),
                                ),
                                Expanded(
                                  child: Consumer<ProductByCategoryProvider>(
                                    builder:
                                        (context, proByCatProvider, child) {
                                      return MultiSelectDropDown<Brand>(
                                        hintText: 'Filter By Brands',
                                        items: proByCatProvider.brands,
                                        onSelectionChanged: (val) {
                                          proByCatProvider.selectedBrands =
                                              val;
                                          context.productByCategoryProvider
                                              .filterProductByBrand();
                                          proByCatProvider.updateUI();
                                        },
                                        displayItem: (val) => val.name ?? '',
                                        selectedItems:
                                            proByCatProvider.selectedBrands,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverToBoxAdapter(
              child: Consumer<ProductByCategoryProvider>(
                builder: (context, proByCaProvider, child) {
                  return ProductGridView(
                    items: proByCaProvider.filteredProduct,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
