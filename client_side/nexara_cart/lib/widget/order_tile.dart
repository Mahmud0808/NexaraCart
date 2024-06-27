import 'package:flutter/material.dart';
import 'package:nexara_cart/utility/functions.dart';

import '../utility/app_color.dart';
import '../utility/constants.dart';

class OrderTile extends StatelessWidget {
  final String items;
  final double? price;
  final String paymentMethod;
  final String date;
  final String status;
  final VoidCallback? onTap;

  const OrderTile({
    super.key,
    required this.items,
    required this.price,
    required this.paymentMethod,
    required this.date,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                items,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkAccent,
                ),
              ),
              Text(
                'Payment : $paymentMethod',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Total : ${formatCurrency(context, price)}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatTimestamp(context, date),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case ORDER_STATUS_PENDING:
        return Colors.grey;
      case ORDER_STATUS_PROCESSING:
        return Colors.orange;
      case ORDER_STATUS_SHIPPED:
        return Colors.blue;
      case ORDER_STATUS_DELIVERED:
        return Colors.green;
      case ORDER_STATUS_CANCELLED:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
