import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/connect.dart';
import 'package:intl/intl.dart';
import 'package:nexara_cart/utility/constants.dart';
import 'package:nexara_cart/utility/snack_bar_helper.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      );
    },
  );
}

bool validatePassword(String? value) {
  if (value == null) return false;

  RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9]).{6,}$');
  if (value.isEmpty) {
    return false;
  } else {
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}

String? isEmailPasswordValid(String email, String password) {
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
      return 'Password is not strong enough!';
    }
  } else {
    return null;
  }

  return null;
}

String formatCurrency(BuildContext context, double? price) {
  return price == null
      ? '${CURRENCY_SYMBOL}0.0'
      : CURRENCY_SYMBOL +
          NumberFormat.decimalPattern(
                  Localizations.localeOf(context).toString())
              .format(price);
}

String formatTimestamp(BuildContext context, String? timestamp) {
  if (timestamp == null) {
    return 'N/A';
  }
  try {
    DateTime dateTime = DateTime.parse(timestamp);
    bool use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    String formatString =
    use24HourFormat ? 'dd/MM/yyyy, HH:mm' : 'dd/MM/yyyy, hh:mm a';
    return DateFormat(formatString).format(dateTime.toLocal());
  } catch (e) {
    return 'Invalid Date';
  }
}

Future<void> checkServerConnectivity() async {
  Future.delayed(Duration.zero, () async {
    try {
      Response response = await GetConnect().get(SERVER_URL);

      if (!response.isOk) {
        SnackBarHelper.showErrorSnackBar('Could not connect to server.');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Could not connect to server.');
    }
  });
}
