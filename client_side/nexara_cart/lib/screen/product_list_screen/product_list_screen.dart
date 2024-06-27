import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widget/product_grid_view.dart';
import '../../core/data/data_provider.dart';
import 'components/category_selector.dart';
import 'components/custom_app_bar.dart';
import 'components/poster_section.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello There",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                )
              ),
              Text(
                "Let's get something?",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const PosterSection(),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Top categories",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 15),
              Consumer<DataProvider>(
                builder: (context, dataProvider, child) {
                  return CategorySelector(
                    categories: dataProvider.categories,
                  );
                },
              ),
              const SizedBox(height: 15),
              Consumer<DataProvider>(
                builder: (context, dataProvider, child) {
                  return ProductGridView(
                    items: dataProvider.products,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
