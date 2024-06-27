import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utility/app_color.dart';

class TrackingScreen extends StatelessWidget {
  final String? url;

  const TrackingScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    WebViewController webViewController = WebViewController();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url ?? 'https://www.google.com/'));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track Order",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkAccent),
        ),
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
