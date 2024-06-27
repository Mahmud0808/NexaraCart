import 'dart:developer';

import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/order.dart';
import '../../../services/http_services.dart';
import '../../../utility/constants.dart';

class OrderProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final orderFormKey = GlobalKey<FormState>();
  TextEditingController trackingUrlCtrl = TextEditingController();
  String selectedOrderStatus = ORDER_STATUS_PENDING;
  Order? orderForUpdate;

  OrderProvider(this._dataProvider);

  updateOrder() async {
    try {
      if (orderForUpdate != null) {
        Map<String, dynamic> order = {
          'trackingUrl': trackingUrlCtrl.text,
          'orderStatus': selectedOrderStatus
        };

        final response = await service.updateItem(
            endpointUrl: 'orders',
            itemId: orderForUpdate?.sId ?? '',
            itemData: order);

        if (response.isOk) {
          ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

          if (apiResponse.success == true) {
            SnackBarHelper.showSuccessSnackBar(apiResponse.message);
            log('order updated');
            _dataProvider.getAllOrders();
          } else {
            SnackBarHelper.showErrorSnackBar(
                'Failed to update order: ${apiResponse.message}');
          }
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Error: ${response.body?['message'] ?? response.statusText}');
        }
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  deleteOrder(Order order) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'orders', itemId: order.sId ?? '');

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar('Order deleted successfully!');
          _dataProvider.getAllOrders();
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  updateUI() {
    notifyListeners();
  }
}
