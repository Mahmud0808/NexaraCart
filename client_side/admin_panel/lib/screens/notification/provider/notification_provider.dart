import 'dart:developer';

import 'package:admin/models/my_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/notification_result.dart';
import '../../../services/http_services.dart';
import '../../../utility/snack_bar_helper.dart';

class NotificationProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final sendNotificationFormKey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descriptionCtrl = TextEditingController();
  TextEditingController imageUrlCtrl = TextEditingController();

  NotificationResult? notificationResult;

  NotificationProvider(this._dataProvider);

  sendNotification() async {
    try {
      Map<String, dynamic> notification = {
        'title': titleCtrl.text,
        'description': descriptionCtrl.text,
        'imageUrl': imageUrlCtrl.text
      };

      final response = await service.addItem(
          endpointUrl: 'notification/send-notification',
          itemData: notification);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          clearFields();

          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('notification sent');

          _dataProvider.getAllNotifications();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to send notification: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      rethrow;
    }
  }

  deleteNotification(MyNotification notification) async {
    try {
      Response response = await service.deleteItem(
          endpointUrl: 'notification/delete-notification',
          itemId: notification.sId ?? '');

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(
              'Notification deleted successfully!');
          _dataProvider.getAllCoupons();
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

  getNotificationInfo(MyNotification? notification) async {
    try {
      if (notification == null) {
        SnackBarHelper.showErrorSnackBar('Something went wrong!');
        return;
      }

      final response = await service.getItems(
          endpointUrl:
              'notification/track-notification/${notification.notificationId}');

      if (response.isOk) {
        final ApiResponse<NotificationResult> apiResponse =
            ApiResponse<NotificationResult>.fromJson(
                response.body,
                (json) =>
                    NotificationResult.fromJson(json as Map<String, dynamic>));

        if (apiResponse.success == true) {
          NotificationResult? myNotificationResult = apiResponse.data;
          notificationResult = myNotificationResult;

          print(notificationResult?.platform);
          log('notification successfully fetched');

          notifyListeners();
          return null;
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to fetch data: ${apiResponse.message}');
          return 'Failed to fetch data: ${apiResponse.message}';
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error: ${response.body?['message'] ?? response.statusText}');
        return 'Error: ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      log(e.toString());
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      return 'An error occurred: $e';
    }
  }

  clearFields() {
    titleCtrl.clear();
    descriptionCtrl.clear();
    imageUrlCtrl.clear();
  }

  updateUI() {
    notifyListeners();
  }
}
