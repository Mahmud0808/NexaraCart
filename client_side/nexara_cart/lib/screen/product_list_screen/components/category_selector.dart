import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/constants.dart';

import '../../../models/category.dart';
import '../../../utility/animation/open_container_wrapper.dart';
import '../../../utility/app_color.dart';
import '../../product_by_category_screen/product_by_category_screen.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;

  const CategorySelector({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.builder(
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.only(right: 12, top: 1, bottom: 1),
            child: OpenContainerWrapper(
              nextScreen:
                  ProductByCategoryScreen(selectedCategory: categories[index]),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        category.image != null
                            ? '$SERVER_URL${category.image}'
                            : '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.grey);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color:
                            category.isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
