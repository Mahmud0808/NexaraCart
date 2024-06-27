import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/brand.dart';
import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../models/variant_type.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/multi_select_drop_down.dart';
import '../../../widgets/product_image_card.dart';
import '../provider/dash_board_provider.dart';

class ProductSubmitForm extends StatelessWidget {
  final Product? product;

  const ProductSubmitForm({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    context.dashBoardProvider.setDataForUpdateProduct(product);

    return SingleChildScrollView(
      child: Form(
        key: context.dashBoardProvider.addProductFormKey,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return ProductImageCard(
                          labelText: 'Main Image',
                          imageFile: dashProvider.selectedMainImage,
                          imageUrlForUpdateImage: product?.images
                                      .safeElementAt(0)
                                      ?.url ==
                                  null
                              ? product?.images.safeElementAt(0)?.url
                              : '${MAIN_URL}${product?.images.safeElementAt(0)?.url}',
                          onTap: () {
                            dashProvider.pickImage(imageCardNumber: 1);
                          },
                          onRemoveImage: () {
                            dashProvider.selectedMainImage = null;
                            dashProvider.updateUI();
                          },
                        );
                      },
                    ),
                    Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return ProductImageCard(
                          labelText: '2nd image',
                          imageFile: dashProvider.selectedSecondImage,
                          imageUrlForUpdateImage: product?.images
                                      .safeElementAt(1)
                                      ?.url ==
                                  null
                              ? product?.images.safeElementAt(1)?.url
                              : '${MAIN_URL}${product?.images.safeElementAt(1)?.url}',
                          onTap: () {
                            dashProvider.pickImage(imageCardNumber: 2);
                          },
                          onRemoveImage: () {
                            dashProvider.selectedSecondImage = null;
                            dashProvider.updateUI();
                          },
                        );
                      },
                    ),
                    Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return ProductImageCard(
                          labelText: '3rd image',
                          imageFile: dashProvider.selectedThirdImage,
                          imageUrlForUpdateImage: product?.images
                                      .safeElementAt(2)
                                      ?.url ==
                                  null
                              ? product?.images.safeElementAt(2)?.url
                              : '${MAIN_URL}${product?.images.safeElementAt(2)?.url}',
                          onTap: () {
                            dashProvider.pickImage(imageCardNumber: 3);
                          },
                          onRemoveImage: () {
                            dashProvider.selectedThirdImage = null;
                            dashProvider.updateUI();
                          },
                        );
                      },
                    ),
                    Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return ProductImageCard(
                          labelText: '4th image',
                          imageFile: dashProvider.selectedFourthImage,
                          imageUrlForUpdateImage: product?.images
                                      .safeElementAt(3)
                                      ?.url ==
                                  null
                              ? product?.images.safeElementAt(3)?.url
                              : '${MAIN_URL}${product?.images.safeElementAt(3)?.url}',
                          onTap: () {
                            dashProvider.pickImage(imageCardNumber: 4);
                          },
                          onRemoveImage: () {
                            dashProvider.selectedFourthImage = null;
                            dashProvider.updateUI();
                          },
                        );
                      },
                    ),
                    Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        return ProductImageCard(
                          labelText: '5th image',
                          imageFile: dashProvider.selectedFifthImage,
                          imageUrlForUpdateImage: product?.images
                                      .safeElementAt(4)
                                      ?.url ==
                                  null
                              ? product?.images.safeElementAt(4)?.url
                              : '${MAIN_URL}${product?.images.safeElementAt(4)?.url}',
                          onTap: () {
                            dashProvider.pickImage(imageCardNumber: 5);
                          },
                          onRemoveImage: () {
                            dashProvider.selectedFifthImage = null;
                            dashProvider.updateUI();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.dashBoardProvider.productNameCtrl,
                labelText: 'Product Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: defaultPadding),
              CustomTextField(
                controller: context.dashBoardProvider.productDescCtrl,
                labelText: 'Product Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(child: Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      List<Category> _sortedCategories =
                          List.from(context.dataProvider.categories);
                      _sortedCategories.sort((a, b) {
                        if (a.name == null && b.name == null) {
                          return 0;
                        } else if (a.name == null) {
                          return 1;
                        } else if (b.name == null) {
                          return -1;
                        } else {
                          return a.name!.compareTo(b.name!);
                        }
                      });

                      return CustomDropdown(
                        key: ValueKey(dashProvider.selectedCategory?.sId),
                        initialValue: dashProvider.selectedCategory,
                        hintText: 'Select category',
                        items: _sortedCategories,
                        displayItem: (Category? category) =>
                            category?.name ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            context.dashBoardProvider
                                .filterSubcategory(newValue);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                      );
                    },
                  )),
                  Expanded(child: Consumer<DashBoardProvider>(
                    builder: (context, dashProvider, child) {
                      List<SubCategory> _sortedSubCategories =
                          List.from(dashProvider.subCategoriesByCategory);
                      _sortedSubCategories.sort((a, b) {
                        if (a.name == null && b.name == null) {
                          return 0;
                        } else if (a.name == null) {
                          return 1;
                        } else if (b.name == null) {
                          return -1;
                        } else {
                          return a.name!.compareTo(b.name!);
                        }
                      });

                      return CustomDropdown(
                        key: ValueKey(dashProvider.selectedSubCategory?.sId),
                        hintText: 'Select Sub Category',
                        items: _sortedSubCategories,
                        initialValue: dashProvider.selectedSubCategory,
                        displayItem: (SubCategory? subCategory) =>
                            subCategory?.name ?? '',
                        onChanged: (newValue) {
                          if (newValue != null) {
                            context.dashBoardProvider.filterBrand(newValue);
                          }
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select sub category';
                          }
                          return null;
                        },
                      );
                    },
                  )),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        List<Brand> _sortedBrands =
                            List.from(dashProvider.brandsBySubCategory);
                        _sortedBrands.sort((a, b) {
                          if (a.name == null && b.name == null) {
                            return 0;
                          } else if (a.name == null) {
                            return 1;
                          } else if (b.name == null) {
                            return -1;
                          } else {
                            return a.name!.compareTo(b.name!);
                          }
                        });

                        return CustomDropdown(
                            key: ValueKey(dashProvider.selectedBrand?.sId),
                            initialValue: dashProvider.selectedBrand,
                            items: _sortedBrands,
                            hintText: 'Select Brand',
                            displayItem: (Brand? brand) => brand?.name ?? '',
                            onChanged: (newValue) {
                              if (newValue != null) {
                                dashProvider.selectedBrand = newValue;
                                dashProvider.updateUI();
                              }
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please brand';
                              }
                              return null;
                            });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productPriceCtrl,
                      labelText: 'Price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter price';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productOffPriceCtrl,
                      labelText: 'Offer price',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: context.dashBoardProvider.productQntCtrl,
                      labelText: 'Quantity',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(width: defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        List<VariantType> _sortedVariantTypes =
                            List.from(context.dataProvider.variantTypes);
                        _sortedVariantTypes.sort((a, b) {
                          if (a.name == null && b.name == null) {
                            return 0;
                          } else if (a.name == null) {
                            return 1;
                          } else if (b.name == null) {
                            return -1;
                          } else {
                            return a.name!.compareTo(b.name!);
                          }
                        });

                        return CustomDropdown(
                          key: ValueKey(dashProvider.selectedVariantType?.sId),
                          initialValue: dashProvider.selectedVariantType,
                          items: _sortedVariantTypes,
                          displayItem: (VariantType? variantType) =>
                              variantType?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              context.dashBoardProvider.filterVariant(newValue);
                            }
                          },
                          hintText: 'Select Variant type',
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<DashBoardProvider>(
                      builder: (context, dashProvider, child) {
                        final filteredSelectedItems = dashProvider
                            .selectedVariants
                            .where((item) => dashProvider.variantsByVariantType
                                .contains(item))
                            .toList();

                        return MultiSelectDropDown(
                          items: dashProvider.variantsByVariantType,
                          onSelectionChanged: (newValue) {
                            dashProvider.selectedVariants = newValue;
                            dashProvider.updateUI();
                          },
                          displayItem: (String item) => item,
                          selectedItems: filteredSelectedItems,
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: defaultPadding),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context
                          .dashBoardProvider.addProductFormKey.currentState!
                          .validate()) {
                        context
                            .dashBoardProvider.addProductFormKey.currentState!
                            .save();
                        context.dashBoardProvider.submitProduct();

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the popup
void showAddProductForm(BuildContext context, Product? product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Product'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: ProductSubmitForm(product: product),
      );
    },
  );
}

extension SafeList<T> on List<T>? {
  T? safeElementAt(int index) {
    // Check if the list is null or if the index is out of range
    if (this == null || index < 0 || index >= this!.length) {
      return null;
    }
    return this![index];
  }
}
