import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../models/my_notification.dart';
import '../../../utility/constants.dart';
import '../provider/notification_provider.dart';
import 'notification_statics_card.dart';

class ViewNotificationForm extends StatelessWidget {
  final MyNotification? notification;

  const ViewNotificationForm({Key? key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.notificationProvider.getNotificationInfo(notification);

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(notification?.title ?? 'N/A',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
            Gap(10),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor, // Light grey background to stand out
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                    color: Colors.blueAccent), // Blue border for emphasis
              ),
              child: Consumer<NotificationProvider>(
                builder: (context, notificationProvider, child) {
                  int totalSend = notificationProvider
                          .notificationResult?.successDelivery ??
                      0;
                  int totalOpened = notificationProvider
                          .notificationResult?.openedNotification ??
                      0;
                  int totalFailed =
                      notificationProvider.notificationResult?.failedDelivery ??
                          0;
                  int totalError = notificationProvider
                          .notificationResult?.erroredDelivery ??
                      0;
                  double calculatePercentage(int notificationCount) {
                    if (totalSend == 0) {
                      return 0;
                    } else {
                      return (notificationCount / totalSend) * 100;
                    }
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NotificationCard(
                        text: 'Total Send',
                        color: Colors.blue,
                        number: totalSend,
                        percentage: calculatePercentage(totalSend),
                      ),
                      NotificationCard(
                        text: 'Total Opened',
                        color: Colors.green,
                        number: totalOpened,
                        percentage: calculatePercentage(totalOpened),
                      ),
                      NotificationCard(
                        text: 'Total Failed',
                        color: Colors.red,
                        number: totalFailed,
                        percentage: calculatePercentage(totalFailed),
                      ),
                      NotificationCard(
                        text: 'Total Error',
                        color: Colors.yellow,
                        number: totalError,
                        percentage: calculatePercentage(totalError),
                      ),
                    ],
                  );
                },
              ),
            ),
            Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// How to show the order popup
void viewNotificationStatics(
    BuildContext context, MyNotification? notification) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Notification Statics'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: ViewNotificationForm(notification: notification),
      );
    },
  );
}
