import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nexara_cart/utility/snack_bar_helper.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../../services/http_services.dart';
import '../../../utility/constants.dart';
import '../../../utility/functions.dart';
import '../login_screen.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final box = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  UserProvider(this._dataProvider);

  Future<String?> login() async {
    String email = emailController.text.trim().toLowerCase();
    String pass = passwordController.text;

    String? validate = _isEmailPasswordValid(email, pass);

    if (validate != null) {
      return validate;
    }

    try {
      Map<String, dynamic> user = {'name': email, 'password': pass};

      final response =
          await service.addItem(endpointUrl: 'users/login', itemData: user);

      if (response.isOk) {
        final ApiResponse<User> apiResponse = ApiResponse<User>.fromJson(
            response.body,
            (json) => User.fromJson(json as Map<String, dynamic>));

        if (apiResponse.success == true) {
          User? user = apiResponse.data;
          saveLoginInfo(user);

          log('login success');
          return null;
        } else {
          return 'Failed to login: ${apiResponse.message}';
        }
      } else {
        return 'Error: ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      log(e.toString());
      return 'An error occurred: $e';
    }
  }

  Future<String?> register() async {
    String email = emailController.text.trim().toLowerCase();
    String pass = passwordController.text;
    String pass2 = passwordController2.text;

    String? validate = _isEmailPasswordValid(email, pass);

    if (validate != null) {
      return validate;
    } else if (pass2.isEmpty) {
      return 'Confirm password to proceed.';
    } else if (pass != pass2) {
      return 'Passwords do not match!';
    }

    try {
      Map<String, dynamic> user = {'name': email, 'password': pass};

      final response =
          await service.addItem(endpointUrl: 'users/register', itemData: user);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);

        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('register success');
          return null;
        } else {
          return 'Failed to register: ${apiResponse.message}';
        }
      } else {
        return 'Error: ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      log(e.toString());
      return 'An error occurred: $e';
    }
  }

  Future<void> saveLoginInfo(User? loginUser) async {
    await box.write(USER_INFO_BOX, loginUser?.toJson());
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
  }

  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }

  logOutUser() {
    box.remove(USER_INFO_BOX);
    Get.offAll(const LoginScreen());
  }

  String? _isEmailPasswordValid(String email, String password) {
    bool isEmailEmpty = email.trim().toLowerCase().isEmpty;
    bool isPasswordEmpty = password.isEmpty;
    bool isValidEmail = EmailValidator.validate(email.trim().toLowerCase());
    bool isStrongPassword = validatePassword(password);

    if (isEmailEmpty || isPasswordEmpty || !isValidEmail || !isStrongPassword) {
      if (isEmailEmpty && isPasswordEmpty) {
        return 'Email and password cannot be empty!';
      } else if (isEmailEmpty) {
        return 'Email cannot be empty!';
      } else if (isPasswordEmpty) {
        return 'Password cannot be empty!';
      } else if (!isValidEmail) {
        return 'Email is not valid!';
      } else if (!isStrongPassword) {
        return 'Please use strong password!';
      }
    } else {
      return null;
    }

    return null;
  }
}
