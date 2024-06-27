import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/functions.dart';
import 'package:provider/provider.dart';

import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../utility/snack_bar_helper.dart';
import '../../../widget/compleate_order_button.dart';
import '../../../widget/custom_dropdown.dart';
import '../../../widget/custom_text_field.dart';
import '../provider/cart_provider.dart';
import 'coupon_text_field.dart';

void showCustomBottomSheet(BuildContext context) {
  context.cartProvider.clearCouponDiscount();
  context.cartProvider.retrieveSavedAddress();

  submitOrder() async {
    showLoadingDialog(context);

    await context.cartProvider.submitOrder().then((result) {
      Navigator.pop(context);

      if (result == null) {
        Navigator.pop(context);
        context.cartProvider.clearCouponDiscount();
        context.cartProvider.clearCartItems();
        SnackBarHelper.showSuccessSnackBar(
            'Your order has been placed successfully.');
      } else {
        SnackBarHelper.showErrorSnackBar(result);
      }
    });
  }

  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: context.cartProvider.buyNowFormKey,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toggle Address Fields
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 6,
                    ),
                    child: ListTile(
                      title: const Text('Shipping Address'),
                      trailing: IconButton(
                        icon: Icon(context.cartProvider.isExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down),
                        onPressed: () {
                          context.cartProvider.isExpanded =
                              !context.cartProvider.isExpanded;
                          (context as Element).markNeedsBuild();
                        },
                      ),
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: -2,
                      ),
                      contentPadding: const EdgeInsets.only(
                        left: 16.0,
                        right: 0.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.cartProvider.isExpanded =
                        !context.cartProvider.isExpanded;
                    (context as Element).markNeedsBuild();
                  },
                ),

                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return Visibility(
                      visible: cartProvider.isExpanded,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            CustomTextField(
                              height: 65,
                              labelText: 'Phone',
                              onSave: (value) {},
                              inputType: TextInputType.number,
                              controller: context.cartProvider.phoneController,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter phone number'
                                  : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'Street',
                              onSave: (val) {},
                              controller: context.cartProvider.streetController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter street' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'City',
                              onSave: (value) {},
                              controller: context.cartProvider.cityController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter city' : null,
                            ),
                            CustomTextField(
                              height: 65,
                              labelText: 'State',
                              onSave: (value) {},
                              controller: context.cartProvider.stateController,
                              validator: (value) =>
                                  value!.isEmpty ? 'Please enter state' : null,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'Postal Code',
                                    onSave: (value) {},
                                    inputType: TextInputType.number,
                                    controller: context
                                        .cartProvider.postalCodeController,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter postal code'
                                        : null,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CustomTextField(
                                    height: 65,
                                    labelText: 'Country',
                                    onSave: (value) {},
                                    controller:
                                        context.cartProvider.countryController,
                                    validator: (value) => value!.isEmpty
                                        ? 'Please enter country'
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Payment Options
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CustomDropdown<String>(
                      hintText: cartProvider.selectedPaymentOption,
                      items: const [PAYMENT_METHOD_COD, PAYMENT_METHOD_PREPAID],
                      onChanged: (val) {
                        cartProvider.selectedPaymentOption =
                            val ?? PAYMENT_METHOD_COD;
                        cartProvider.updateUI();
                      },
                      displayItem: (val) => val,
                    );
                  },
                ),
                // Coupon Code Field
                Row(
                  children: [
                    Expanded(
                      child: CouponTextField(
                        height: 60,
                        labelText: 'Enter Coupon Code',
                        onSave: (value) {},
                        controller: context.cartProvider.couponController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          context.cartProvider.checkCoupon();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Apply'),
                      ),
                    )
                  ],
                ),
                //? Text for Total Amount, Total Offer Applied, and Grand Total
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                  child: Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      return Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Subtotal :',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Discount :',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Total :',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatCurrency(
                                    context, cartProvider.getCartSubTotal()),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                formatCurrency(
                                    context, cartProvider.couponCodeDiscount),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                formatCurrency(
                                    context, cartProvider.getGrandTotal()),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
                //? Pay Button
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    return CompleteOrderButton(
                        labelText:
                            'Complete Order ${formatCurrency(context, cartProvider.getGrandTotal())}',
                        onPressed: () {
                          if (!cartProvider.isExpanded) {
                            cartProvider.isExpanded = true;
                            cartProvider.updateUI();
                            return;
                          }
                          // Check if the form is valid
                          if (context.cartProvider.buyNowFormKey.currentState!
                              .validate()) {
                            context.cartProvider.buyNowFormKey.currentState!
                                .save();
                            submitOrder();
                            return;
                          }
                        });
                  },
                )
              ],
            ),
          ),
        ),
      );
    },
    isScrollControlled: true,
  );
}
