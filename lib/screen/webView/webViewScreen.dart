// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:ottu/consts/colors.dart';
import 'package:ottu/screen/webView/utils/webviewfunctions.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView Screen
class WebViewScreen extends StatefulWidget {
  final String? webviewURL;
  final String sessionId;
  const WebViewScreen({super.key, this.webviewURL, required this.sessionId});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) => debugPrint('Page started loading: $url'),
        onPageFinished: (url) => debugPrint('Page finished loading: $url'),
        onNavigationRequest: (request) {
          WebViewFunctions.navigate(context, request.url, widget.sessionId);
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.webviewURL ?? 'about:blank'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          iconTheme: const IconThemeData(
            color: Colors.black, // Change your color here
          ),
        ),
        body: SafeArea(
          child: WebViewWidget(controller: _webViewController),
        ),
      ),
    );
  }
}
