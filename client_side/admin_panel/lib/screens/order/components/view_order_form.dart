import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../models/order.dart';
import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/order_provider.dart';

class OrderSubmitForm extends StatelessWidget {
  final Order? order;

  const OrderSubmitForm({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.orderProvider.trackingUrlCtrl.text = order?.trackingUrl ?? '';
    context.orderProvider.orderForUpdate = order;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        width: MediaQuery.of(context).size.width *
            0.5, // Adjust width based on screen size
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: Provider.of<OrderProvider>(context, listen: false).orderFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: formRow(
                          'Name:',
                          Text(order?.userID?.name ?? 'N/A',
                              style: TextStyle(fontSize: 16)))),
                  Expanded(
                      child: formRow(
                          'Order Id:',
                          Text(order?.sId ?? 'N/A',
                              style: TextStyle(fontSize: 12)))),
                ],
              ),
              itemsSection(),
              addressSection(),
              Gap(10),
              paymentDetailsSection(),
              formRow(
                'Order Status:',
                Consumer<OrderProvider>(
                  builder: (context, orderProvider, child) {
                    return CustomDropdown(
                      hintText: 'Status',
                      initialValue: orderProvider.selectedOrderStatus,
                      items: [
                        ORDER_STATUS_PENDING,
                        ORDER_STATUS_PROCESSING,
                        ORDER_STATUS_SHIPPED,
                        ORDER_STATUS_DELIVERED,
                        ORDER_STATUS_CANCELLED
                      ],
                      displayItem: (val) => val,
                      onChanged: (newValue) {
                        orderProvider.selectedOrderStatus =
                            newValue ?? ORDER_STATUS_PENDING;
                        orderProvider.updateUI();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select status';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ),
              formRow(
                  'Tracking URL:',
                  CustomTextField(
                    labelText: 'Tracking Url',
                    onSave: (val) {},
                    controller: context.orderProvider.trackingUrlCtrl,
                  )),
              Gap(defaultPadding * 2),
              actionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget formRow(String label, Widget dataWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Text(label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
          Expanded(flex: 2, child: dataWidget),
        ],
      ),
    );
  }

  Widget addressSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor, // Light grey background to stand out
        borderRadius: BorderRadius.circular(8.0),
        border:
            Border.all(color: Colors.blueAccent), // Blue border for emphasis
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Shipping Address',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
          ),
          formRow(
              'Phone:',
              Text(order?.shippingAddress?.phone ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Street:',
              Text(order?.shippingAddress?.street ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'City:',
              Text(order?.shippingAddress?.city ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Postal Code:',
              Text(order?.shippingAddress?.postalCode ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Country:',
              Text(order?.shippingAddress?.country ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Widget paymentDetailsSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Payment Details',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          formRow(
              'Payment Method:',
              Text(order?.paymentMethod ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Coupon Code:',
              Text(order?.couponCode?.couponCode ?? 'N/A',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Order Sub Total:',
              Text(
                  '\$${order?.orderTotal?.subTotal?.toStringAsFixed(2) ?? 'N/A'}',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Discount:',
              Text(
                  '\$${order?.orderTotal?.discount?.toStringAsFixed(2) ?? 'N/A'}',
                  style: TextStyle(fontSize: 16, color: Colors.red))),
          formRow(
              'Grand Total:',
              Text('\$${order?.orderTotal?.total?.toStringAsFixed(2) ?? 'N/A'}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget itemsSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Items',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          _buildItemsList(),
          SizedBox(height: defaultPadding),
          // Add some spacing before the total price
          formRow(
            'Total Price:',
            Text('\$${order?.totalPrice?.toStringAsFixed(2) ?? 'N/A'}',
                style: TextStyle(fontSize: 16, color: Colors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    if (order?.items == null || order!.items!.isEmpty) {
      return Text('No items', style: TextStyle(fontSize: 16));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // Disable scrolling within ListView
      itemCount: order!.items!.length,
      itemBuilder: (context, index) {
        final item = order!.items![index];
        return Padding(
          padding: EdgeInsets.only(bottom: 4.0), // Add spacing between items
          child: Text(
              '${item.productName}: ${item.quantity} x \$${item.price?.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  Widget actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        Gap(defaultPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            if (Provider.of<OrderProvider>(context, listen: false)
                .orderFormKey
                .currentState!
                .validate()) {
              Provider.of<OrderProvider>(context, listen: false)
                  .orderFormKey
                  .currentState!
                  .save();
              context.orderProvider.updateOrder();
              Navigator.of(context).pop();
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// How to show the order popup
void showOrderForm(BuildContext context, Order? order) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Order Details'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: OrderSubmitForm(order: order),
      );
    },
  );
}
