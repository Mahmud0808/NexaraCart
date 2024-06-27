import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../models/category.dart';
import '../../../models/coupon.dart';
import '../../../models/product.dart';
import '../../../models/sub_category.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/coupon_code_provider.dart';

class CouponSubmitForm extends StatelessWidget {
  final Coupon? coupon;

  const CouponSubmitForm({Key? key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.couponCodeProvider.setDataForUpdateCoupon(coupon);
    return SingleChildScrollView(
      child: Form(
        key: context.couponCodeProvider.addCouponFormKey,
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
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.couponCodeCtrl,
                      labelText: 'Coupon Code',
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter coupon code';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown(
                      key: GlobalKey(),
                      hintText: 'Discount Type',
                      // do not change items, or must change in server side too
                      items: ['fixed', 'percentage'],
                      initialValue:
                          context.couponCodeProvider.selectedDiscountType,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedDiscountType =
                            newValue ?? 'fixed';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a discount type';
                        }
                        return null;
                      },
                      displayItem: (val) => val,
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: context.couponCodeProvider.discountAmountCtrl,
                      labelText: 'Discount Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter discount amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller:
                          context.couponCodeProvider.minimumPurchaseAmountCtrl,
                      labelText: 'Minimum Purchase Amount',
                      inputType: TextInputType.number,
                      onSave: (val) {},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select purchase amount';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
              Row(
                children: [
                  Expanded(
                    child: CustomDatePicker(
                      labelText: 'Select Date',
                      controller: context.couponCodeProvider.endDateCtrl,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateSelected: (DateTime date) {
                        print('Selected Date: $date');
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomDropdown(
                      key: GlobalKey(),
                      hintText: 'Status',
                      initialValue:
                          context.couponCodeProvider.selectedCouponStatus,
                      items: ['active', 'inactive'],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        context.couponCodeProvider.selectedCouponStatus =
                            newValue ?? 'active';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
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
                          initialValue: couponProvider.selectedCategory,
                          hintText: 'Select Category',
                          items: _sortedCategories,
                          displayItem: (Category? category) =>
                              category?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedCategory = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        List<SubCategory> _sortedSubCategories =
                            List.from(context.dataProvider.subCategories);
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
                          initialValue: couponProvider.selectedSubCategory,
                          hintText: 'Select Sub Category',
                          items: _sortedSubCategories,
                          displayItem: (SubCategory? subCategory) =>
                              subCategory?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedProduct = null;
                              couponProvider.selectedSubCategory = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Consumer<CouponCodeProvider>(
                      builder: (context, couponProvider, child) {
                        List<Product> _sortedProducts =
                            List.from(context.dataProvider.products);
                        _sortedProducts.sort((a, b) {
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
                          initialValue: couponProvider.selectedProduct,
                          hintText: 'Select Product',
                          items: _sortedProducts,
                          displayItem: (Product? product) =>
                              product?.name ?? '',
                          onChanged: (newValue) {
                            if (newValue != null) {
                              couponProvider.selectedCategory = null;
                              couponProvider.selectedSubCategory = null;
                              couponProvider.selectedProduct = newValue;
                              couponProvider.updateUi();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(defaultPadding),
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
                          .couponCodeProvider.addCouponFormKey.currentState!
                          .validate()) {
                        context
                            .couponCodeProvider.addCouponFormKey.currentState!
                            .save();
                        context.couponCodeProvider.submitCoupon();

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
void showAddCouponForm(BuildContext context, Coupon? coupon) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Create Coupon'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: CouponSubmitForm(coupon: coupon),
      );
    },
  );
}
