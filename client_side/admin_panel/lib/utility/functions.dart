import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

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

String formatCurrency(BuildContext context, double? price) {
  return price == null
      ? '${currency_symbol}0.0'
      : currency_symbol +
          NumberFormat.decimalPattern(
                  Localizations.localeOf(context).toString())
              .format(price);
}
